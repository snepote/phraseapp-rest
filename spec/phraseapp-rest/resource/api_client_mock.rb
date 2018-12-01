# frozen_string_literal: true

require_relative '../../../lib/phraseapp-rest/resource/response'
require_relative '../../../lib/phraseapp-rest/resource/parser'

module ApiClientMock
  def self.fixture(resource_type, filename)
    File.read(File.join(File.dirname(__FILE__), 'fixtures', resource_type, filename))
  end

  def self.resource(resource_type, filename, code: 200)
    Phraseapp::Rest::Resource::Response.new(
      code: code,
      body: Phraseapp::Rest::Resource::Parser.parse(fixture(resource_type, filename))
    )
  end

  def self.response(code: 200, body:)
    Phraseapp::Rest::Resource::Response.new(
      code: code,
      body: Phraseapp::Rest::Resource::Parser.parse(body)
    )
  end
end
