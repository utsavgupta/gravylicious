#!/usr/bin/env ruby

require 'test/unit'
require 'gravylicious'

class TestGravylicious < Test::Unit::TestCase
  @@gravatar = Gravylicious.new("god@heaven.com\n", true)

  def test_email_hash
    assert_equal(@@gravatar.email_hash, "f1260e36d2bbf84ed621e387410c4a61")
    assert_equal(Gravylicious.new("     man@earth.com  ").email_hash, "f8872d66ac8c25ebd5a84e027873629b")
  end
  
  def test_use_https
    assert_match(/https:\/\/secure\./, @@gravatar.avatar_url)
    @@gravatar.use_https = false
    assert_match(/http:\/\//, @@gravatar.avatar_url)
  end
  
  def test_filters
    assert_equal(Gravylicious.common_filters['sanitize_url'].call('http://example.com/album?p=picture_1.jpg'), 'http%3A%2F%2Fexample.com%2Falbum%3Fp%3Dpicture_1.jpg')
  end
end
