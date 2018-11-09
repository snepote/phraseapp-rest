# phraseapp-rest

## Requirements
- Create a read-only token at Phraseapp
- Set the ENVVAR `PHRASEAPP_API_KEY` with the token value

## Usage
Get the api client using the factory
```ruby
api = Phraseapp::Rest::Factory.api
```
### List of projects
```ruby
project = Phraseapp::Rest::Resource::Project.new(client: api)
project.list.each do |p|
  puts "#{p.id} #{p.updated_at} #{p.name}"
end
```
### List of locales by project_id
```ruby
project_id = 'abcd1234cdef1234abcd1234cdef1234' # 2015-01-28T09:52:53Z My Android Project
locale = Phraseapp::Rest::Resource::Locale.new(client: api, project_id: project_id)
locale.list.each do |l|
  puts "#{l.id} #{l.updated_at} #{l.name} #{l.code}"
end
```
## Phraseapp Api reference
https://developers.phraseapp.com/api/
