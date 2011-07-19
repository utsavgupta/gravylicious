# A ruby library for generating Gravatar urls.
# Author:: Utsav Gupta
# Copyright:: Copyright (c) 2011 Utsav Gupta
# License::   MIT License
require 'digest/md5'
require 'uri'

class Gravylicious
  attr_accessor :email, :params, :param_filters, :use_https
  
  # A hash to store commonly used filters
  # like sanitize_url for escaping urls.
  @@common_filters = {'sanitize_url' => proc{|link| URI.escape(link, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))},
                     }
  
  # The constructor takes the email address and an optional boolean 
  # parameter which specifies whether or not to use https requests,
  # by deafault it's set to fasle. It stores the email address in @email
  # and sets up a collection of default filters in @param_filters.
  def initialize(email, use_https = false)
    @email = email.strip
    @use_https = use_https
    
    @params = Hash.new
    
    @param_filters = {'d' => @@common_filters['sanitize_url'],
                      's' => proc{|s| raise("Invalid avatar size: The requested size is #{s}, valid range 1 to 512") if (s < 1 || s > 512); s},
                      'r' => proc{|r| raise("Invalid avatar rating: Select from g, pg, r and x") unless r =~ /^(p?)g$|^r$|^x$/; r}
                     }
  end
  
  # Class function that returns the common_filters hash.
  def self.common_filters
    @@common_filters
  end
  
  # Returns the MD5 hash of the email address.
  def email_hash
    Digest::MD5.hexdigest(@email.downcase)
  end
  
  # Returns the link to the desired Gravatar.
  def avatar_url
    g_url = "http#{'s' if @use_https}://#{'secure.' if @use_https}gravatar.com/avatar/#{email_hash}"
    
    if params.size > 0    # If the list of parameters is not empty then append
      g_url += "?"
      
      @params.each do |param|
        # If the value of the parameter is not nil then either apply filter or append the orginal value (ie. if it has no filter).
        
        if param[1]
          g_url += param[0] + "=" + ((@param_filters[param[0]].call(param[1]) if @param_filters[param[0]]) || param[1]).to_s + "&"
        end
      
      end
      
      g_url = g_url[0...-1]
    end
    
    g_url
  end
  
  # Used for loading the fallback(default) avatar by defaut.
  def avatar_force_load
    @params['f'] = 'y'
    self
  end
  
  # Unsets the force_load options.  
  def avatar_unforce_load
    @params.delete('f') if @params.has_key?('f')
    self
  end
  
  # Returns the avatar rating.
  def avatar_rating
    @params['r']
  end
  
  # Returns the link to the default avatar.
  def avatar_default
    @params['d']
  end
  
  # Returns the size of the avatar.
  def avatar_size
    @params['s']
  end
  
  # Sets the rating of the avatar.
  # Example gravatar.avatar_rating = 'pg' # Choose from g, pg, r and x.
  def avatar_rating=(r)
    @params['r'] = r
  end
  
  # Sets the default avatar.
  # Example gravatar.avatar_default = "http://example.com/yourpic.jpg"
  def avatar_default=(d)
    @params['d'] = d
  end
  
  # Sets the size of the avatar in px.
  # Example gravatar.avatar_size = 128 # Should not exceed 512
  def avatar_size=(s)
    @params['s'] = s
  end
end
