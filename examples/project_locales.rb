# frozen_string_literal: true

### Return all locales for the first 50 projects

require 'benchmark'
require 'phraseapp-rest'

Phraseapp::Rest.configure do |config|
  config.token = ENV['PHRASEAPP_API_KEY']
end
api = Phraseapp::Rest::Factory.api
page = Phraseapp::Rest::Resource::Page.new(size: 50)

benchmark = Benchmark.measure do
  Phraseapp::Rest::Resource::Project.new(client: api).list(page: page).each do |project|
    locales = Phraseapp::Rest::Resource::Locale.new(client: api, project_id: project[:id])
    puts "#{project[:name]} #{locales.list.group_by { |l| l[:name] }.keys.join(' ')}"
  end
end
puts benchmark
