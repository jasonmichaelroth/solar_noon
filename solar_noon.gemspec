# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "solar_noon"
  s.version     = "1.0.0.pre"
  s.authors     = ["Jason Roth"]
  s.email       = ["jasonmichaelroth@gmail.com"]
  s.homepage    = "https://github.com/jasonmichaelroth/solar_noon"
  s.summary     = "A solar noon calculator."
  s.description = %q{
    This gem extends Date, Time and DateTime with solar noon calculation
    functions. It is based on the NOAA solar noon calculator:
      http://www.esrl.noaa.gov/gmd/grad/solcalc
  }

  s.rubyforge_project = "solar_noon"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'minitest', '~> 5'

end
