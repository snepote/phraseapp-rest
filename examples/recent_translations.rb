# frozen_string_literal: true

require 'benchmark'
require 'time'
require 'phraseapp-rest'

### Gets the first 100 translations updated after 7 days ago, for the locales ch_en and ch_fr of every project

last_update = Time.now - 7 * 86_400 # 7 days ago
locale_names = %w(ch_en ch_fr)

Phraseapp::Rest.configure do |config|
  config.token = ENV['PHRASEAPP_API_KEY']
end

benchmark = Benchmark.measure do
  api = Phraseapp::Rest::Factory.api

  # projects
  projects = Phraseapp::Rest::Resource::Project.new(client: api)
  projects.list(updated_after: last_update).each do |project|
    puts "[project] #{project[:id]} #{project[:updated_at]} #{project[:name]}"

    # locales
    locales = Phraseapp::Rest::Resource::Locale.new(client: api, project_id: project[:id])
    locales.list(updated_after: last_update, names: locale_names).each do |locale|
      puts "  [locale] #{locale[:id]} #{locale[:updated_at]} #{locale[:name]}"

      # translations
      param = Phraseapp::Rest::Parameter::Base.new(sort: 'updated_at', order: 'desc')
      query = Phraseapp::Rest::Query::Base.new(updated_at: ">=#{last_update.iso8601}")
      page = Phraseapp::Rest::Resource::Page.new(number: 1, size: 100)
      translations = Phraseapp::Rest::Resource::Translation.new(client: api, project_id: project[:id])
      translations
        .list_by_locale(locale_id: locale[:id], param: param, query: query, page: page)
        .each do |t|
        puts "    #{t[:id]} #{t[:updated_at]} #{t[:key][:name]}"
      end
    end
  end
end
puts benchmark
