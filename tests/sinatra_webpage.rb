#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'gravylicious'

get '/' do
  gravatar = Gravylicious.new("you@example.com")
  gravatar.avatar_size = 128
  gravatar.avatar_default = "identicon"
  gravatar.avatar_rating = 'g'
  "<img src=\"#{gravatar.avatar_url}\" />"
end
