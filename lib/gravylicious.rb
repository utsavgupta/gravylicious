require 'digest/md5'
require 'uri'

class Gravylicious
  attr_accessor :email, :params, :param_filters, :use_https
  
  # A hash to store commonly used filters  
  @@common_filters = {'sanitize_url' => proc{|link| URI.escape(link, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))},
                     }
  
  def initialize(email, use_https = false)
    @email = email.strip
    @use_https = use_https
    
    @params = Hash.new
    
    # Define the default filters
    @param_filters = {'d' => @@common_filters['sanitize_url'],
                      's' => proc{|s| raise("Invalid avatar size: The requested size is #{s}, valid range 1 to 512") if (s < 1 || s > 512); s},
                      'r' => proc{|r| raise("Invalid avatar rating: Select from g, pg, r and x") unless r =~ /^(p?)g$|^r$|^x$/; r}
                     }
  end
  
  def self.common_filters
    @@common_filters
  end
  
  def email_hash
    Digest::MD5.hexdigest(@email.downcase)
  end
  
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
  
  def avatar_force_load
    @params['f'] = 'y'
    self
  end
  
  def avatar_unforce_load
    @params.delete('f') if @params.has_key?('f')
    self
  end
  
  def avatar_rating
    @params['r']
  end
  
  def avatar_default
    @params['d']
  end
  
  def avatar_size
    @params['s']
  end
  
  def avatar_rating=(r)
    @params['r'] = r
  end
  
  def avatar_default=(d)
    @params['d'] = d
  end
  
  def avatar_size=(s)
    @params['s'] = s
  end
end
