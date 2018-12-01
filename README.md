# phraseapp-rest

[![Build Status](https://travis-ci.org/snepote/phraseapp-rest.svg?branch=master)](https://travis-ci.org/snepote/phraseapp-rest)

## Requirements
- Create a read-only token at Phraseapp
- Set an ENVVAR with `YOUR_PHRASEAPP_API_KEY`

## Notes and disclaimer
It's important to mention that all the resources that supports paginations uses the default Phraseapp pagination (page:1, per_page: 25) but explicitly declared as a default value of the Page object.

** Disclaimer **
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
### For more examples, check ```/examples``` folder

## Phraseapp Api reference
https://developers.phraseapp.com/api/
