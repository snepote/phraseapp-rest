# phraseapp-rest

[![Build Status](https://travis-ci.org/snepote/phraseapp-rest.svg?branch=master)](https://travis-ci.org/snepote/phraseapp-rest)

## Requirements
- Create a read-only token at Phraseapp
- Set an ENVVAR with `YOUR_PHRASEAPP_API_KEY`

## Notes
It's important to mention that all the resources that supports paginations uses the default Phraseapp pagination (page:1, per_page: 25) but explicitly declared as a default value of the Page object.

## DISCLAIMER
### This is still a BETA!
Some of the methods signatures could change. I aim to keep always backward compatibility, but until the first major version (1.x.x) is released, it's still in beta.

Keep in mind that Phraseapp do not recommend to user the lists to retrieve all the items but to use the "#locale_download" instead. The limits of how many items per page are supported, has not been tested.

## Configuration
```ruby
Phraseapp::Rest.configure do |config|
  config.token = ENV['YOUR_PHRASEAPP_API_KEY']
end
```

## Usage
Get the api client using the factory
```ruby
api = Phraseapp::Rest::Factory.api
```
### List of projects
```ruby
project = Phraseapp::Rest::Resource::Project.new(client: api)
project.list.each do |p|
  puts "#{p[:name]} #{p[:updated_at]} #{p[:name]}"
end
```
### List of locales by project_id
```ruby
project_id = 'abcd1234cdef1234abcd1234cdef1234' # 2015-01-28T09:52:53Z My Android Project
locale = Phraseapp::Rest::Resource::Locale.new(client: api, project_id: project_id)
locale.list.each do |l|
  puts "#{l[:id]} #{l[:updated_at]} #{l[:name]} #{l[:code]}"
end
```

### Downloads and print all translations from the first 25 the projects and first 25 locales
```ruby
Phraseapp::Rest::Resource::Project.new(client: api).list.each do |project|
  puts "[project] #{project[:id]} #{project[:updated_at]} #{project[:name]}"
  Phraseapp::Rest::Resource::Locale.new(client: api, project_id: project[:id]).list.each do |locale|
    puts "  [locale] #{locale[:id]} #{locale[:updated_at]} #{locale[:name]}"
    puts locales.download(id: locale[:id])
  end
end
```

### Gets the first 100 translations updated after 7 days ago, for the locales ch_en and ch_fr of every project
```ruby
last_update = Time.now - 7 * 86_400 # 7 days ago
locale_names = %w(ch_en ch_fr)

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
```

## Phraseapp Api reference
https://developers.phraseapp.com/api/
