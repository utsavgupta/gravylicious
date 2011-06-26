#README

###Installation

    $ sudo gem install gravylicious

###Usage

Creating a gravatar object

    > gravatar = Gravylicious.new("you@example.com", true)                    # Omit the second paramater if you don't 
                                                                              # want a https connection. Later you may
                                                                              # change it using 'gravatar.use_https=true'.

Getting the email hash

    > gravatar.email_hash                                                     # Returns the MD5 hash of the email address.

Getting the avatar url

    > gravatar.avatar_url                                                     # Voila there you have your gravatar url !!

Setting and getting the default avatar

    > gravatar.avatar_default = "http://somesite.com/images?img=backup.jpg"   # Lets you set the fallback avatar.
                                                                              # You can use the gravatar defaults
                                                                              # identicon, monstericon, 404, mm, wavatar
                                                                              # and retro.

    > gravatar.avatar_default                                                 # Returns the fallback avatar.
    => "http://somesite.com/images?img=backup.jpg"

Setting and getting the rating of the avatar

    > gravatar.avatar_rating = 'pg'                                           # Assign a rating from g, pg, r and x.
 
    > gravatar.avatar_rating                                                  # Returns the avatar rating.
    => "pg"
 
Setting and getting the avatar size

    > gravatar.avatar_size = 128                                              # Assing the avatar's size in pixels.

    > gravatar.avatar_size                                                    # Returns the size of the avatar.
    => 128

Setting and unsetting the force load option

    > gravatar.avatar_force_load                                              # Loads the fallback avatar by default.

    > gravatar.avatar_unforce_load                                            # Reverses the action of avatar_force_load.

###Under the hood

The parameters are stored in a hash called 'params'. So the assignments can be done manually. 
For instance gravatar.avatar\_size = 128 can be written as:

    > gravatar.params['s'] = 128

  Before returning the avatar's url the paramaters are filtered. You can find the respective filters in
  the param\_filters hash. For example the default avatar parameter will contain a link to some image file 
  hosted by some external site. For this reason you might want to escape the URL properly before making the
  request. Don't worry Gravylicious does it for you! You can remove the filter by

    > gravatar.param_filters['d'] = nil

  Or you can come up with your custom filters. For example if you want to restrict the size of the avatar
  to 32px then you can write something similar to this.

    > gravatar.param_filters['s'] = proc{|s| s = 32}

###LICENSE

  This library was released under the MIT license. Checkout the LICENSE file for more information.
