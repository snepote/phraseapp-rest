# frozen_string_literal: true

# downloads complete locales of all the projects updated after 3 days ago

require_relative '../lib/phraseapp-rest'

Phraseapp::Rest.configure do |config|
  config.token = ENV['PHRASEAPP_API_KEY']
end

three_days_ago = Time.now - 60 * 60 * 24 * 3
last_update = three_days_ago
api = Phraseapp::Rest::Factory.api

projects = Phraseapp::Rest::Resource::Project.new(client: api)
projects.list(updated_after: last_update).each do |project|
  puts "[project] #{project[:id]} #{project[:updated_at]} #{project[:name]}"
  locales = Phraseapp::Rest::Resource::Locale.new(client: api, project_id: project[:id])
  locales.list(updated_after: last_update).each do |locale|
    puts "  [locale] #{locale[:id]} #{locale[:updated_at]} #{locale[:name]}"
    puts locales.download(id: locale[:id])
  end
end
