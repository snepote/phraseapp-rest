# frozen_string_literal: true

### Count duplicated keys across different projects

require 'time'
require 'benchmark'
require 'phraseapp-rest'

Phraseapp::Rest.configure do |config|
  config.token = ENV['PHRASEAPP_API_KEY']
end
api = Phraseapp::Rest::Factory.api

counter = {}
benchmark = Benchmark.measure do
  Phraseapp::Rest::Resource::Project.new(client: api).list.each do |project|
    puts "[project] #{project[:id]} #{project[:updated_at]} #{project[:name]}"
    locales = Phraseapp::Rest::Resource::Locale.new(client: api, project_id: project[:id])
    locales.list(names: ['en']).each do |locale|
      puts "  [locale] #{locale[:id]} #{locale[:updated_at]} #{locale[:name]}"
      JSON.parse(locales.download(id: locale[:id]), symbolize_names: true).keys.each do |key|
        if counter.key? key
          counter[key][:count] = counter[key][:count] + 1
          counter[key][:projects] << project[:name]
        else
          counter[key] = { count: 1, projects: [project[:name]] }
        end
      end
    end
  end
end
counter.delete_if { |_k, v| v[:count] == 1 }
puts counter.to_json
puts benchmark
