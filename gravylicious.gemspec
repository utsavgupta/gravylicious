require 'rubygems'

SPEC = Gem::Specification.new do |s|
  s.name = "gravylicious"
  s.version = "1.0.0"
  s.author = "Utsav Gupta"
  s.homepage = "https://github.com/utsavgupta"
  s.email = "utsavgupta89@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "A library for generating Gravatar urls."
  s.files = Dir.glob("{lib, tests}/**/*")
  s.require_path = "lib"
  s.autorequire = "gravylicious"
  s.test_files = ["tests/tc_gravylicious.rb", "tests/sinatra_webpage.rb"]
  s.add_dependency("sinatra", ">=1.2.6")
end
