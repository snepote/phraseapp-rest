# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phraseapp-rest/version'

Gem::Specification.new do |s|
  s.name        = 'phraseapp-rest'
  s.version     = Phraseapp::Rest::VERSION
  s.date        = '2018-11-09'
  s.summary     = "Phraseapp rest api resource collection"
  s.description = "A ruby gem to interact with Phraseapp REST resources"
  s.authors     = ["Sebastian Nepote"]
  s.email       = 'snepote@gmail.com'
  s.files       = ["lib/phraseapp-rest.rb"]
  s.homepage    = 'http://rubygems.org/gems/phraseapp-rest'
  s.license     = 'MIT'
end
