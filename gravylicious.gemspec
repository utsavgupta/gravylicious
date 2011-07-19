require 'rubygems'

SPEC = Gem::Specification.new do |s|
  s.name = "gravylicious"
  s.version = "1.0.2"
  s.author = "Utsav Gupta"
  s.homepage = "https://github.com/utsavgupta/gravylicious"
  s.email = "utsavgupta89@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "A library for generating Gravatar urls."
  s.files = Dir.glob("{lib, tests}/**/*")
  s.has_rdoc = true
  s.require_path = "lib"
  s.autorequire = "gravylicious"
  s.test_file = "tests/tc_gravylicious.rb"
end
