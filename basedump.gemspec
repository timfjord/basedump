# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "basedump/version"

Gem::Specification.new do |s|
  s.name        = "basedump"
  s.version     = Basedump::VERSION
  s.authors     = ["Tima Maslyuchenko"]
  s.email       = ["dudapip3@gmail.com"]
  s.homepage    = "http://ka4e4ka.com"
  s.summary     = %q{Basecamp time entries dumper}
  s.description = %q{CLI tool for adding basecamp time entries}
  
  s.rubyforge_project = "basedump"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "basecamp"
  s.add_dependency "thor"
  
  s.add_development_dependency "rspec", "~> 2.6"
  s.add_development_dependency "cucumber"
  s.add_development_dependency "aruba"
end
