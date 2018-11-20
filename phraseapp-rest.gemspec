# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phraseapp-rest/version'
require 'time'

Gem::Specification.new do |s|
  s.name        = 'phraseapp-rest'
  s.version     = Phraseapp::Rest::VERSION
  s.date        = Time.new.strftime('%Y-%m-%d')
  s.summary     = 'Phraseapp rest api resource collection'
  s.description = 'A ruby gem to interact with Phraseapp REST resources'
  s.authors     = ['Sebastian Nepote']
  s.email       = 'snepote@gmail.com'
  s.files       = `git ls-files ./lib`.split($RS)
  s.homepage    = 'https://rubygems.org/gems/phraseapp-rest'
  s.metadata    = { 'source_code_uri' => 'https://github.com/snepote/phraseapp-rest' }
  s.license     = 'MIT'
end
