# frozen_string_literal: true

### Downloads and print all translations from the first 25 the projects and first 25 locales

require 'time'
require 'benchmark'
require 'phraseapp-rest'

Phraseapp::Rest.configure do |config|
  config.token = ENV['PHRASEAPP_API_KEY']
end
api = Phraseapp::Rest::Factory.api

benchmark = Benchmark.measure do
  Phraseapp::Rest::Resource::Project.new(client: api).list.each do |project|
    puts "[project] #{project[:id]} #{project[:updated_at]} #{project[:name]}"
    locales = Phraseapp::Rest::Resource::Locale.new(client: api, project_id: project[:id])
    locales.list.each do |locale|
      puts "  [locale] #{locale[:id]} #{locale[:updated_at]} #{locale[:name]}"
      puts locales.download(id: locale[:id])
    end
  end
end
puts benchmark
