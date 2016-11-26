# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flight_controls/version'

Gem::Specification.new do |spec|
  spec.name          = 'flight_controls'
  spec.version       = FlightControls::VERSION
  spec.authors       = ['Luke McFarlane']
  spec.email         = ['lukemcf@gmail.com']

  spec.summary       = 'Control X-Plane Flight Simulator using Arduino & Firmata'
  spec.homepage      = 'https://github.com/lukemcfarlane/flight_controls'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib}/**/*']
  spec.bindir        = 'bin'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'

  spec.add_runtime_dependency 'arduino_firmata'
end
