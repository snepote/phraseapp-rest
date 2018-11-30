# frozen_string_literal: true

require_relative '../../../lib/phraseapp-rest/resource/translation'
require_relative '../../../lib/phraseapp-rest/resource/response'
require_relative '../../../lib/phraseapp-rest/resource/parser'
require_relative 'api_client_mock'

RSpec.describe Phraseapp::Rest::Resource::Translation do
  subject { described_class.new(client: api, project_id: project_id) }
  let(:resource_type) { described_class.to_s.split('::').last.downcase }
  let(:project_id) { 'project_id' }
  let(:locale_id) { 'locale_id' }
  let(:api) { double('Api') }
  let(:parser) { Phraseapp::Rest::Resource::Parser }

  it 'returns one translation for the given id' do
    allow(api).to receive(:get)
      .with("/projects/#{project_id}/translations/abcd1234cdef1234abcd1234cdef1234")
      .and_return(
        Phraseapp::Rest::Resource::Response.new(
          code: 200,
          body: ApiClientMock.fixture(resource_type, 'get.json')
        )
      )
    translation = parser.parse(subject.get(id: 'abcd1234cdef1234abcd1234cdef1234').body)
    expect(translation[:id]).to eq 'abcd1234cdef1234abcd1234cdef1234'
    expect(translation[:content]).to eq 'My translation'
  end

  it 'returns a list of two translations' do
    allow(api).to receive(:get).with("/projects/#{project_id}/translations?page=1&per_page=25").and_return(
      Phraseapp::Rest::Resource::Response.new(
        code: 200,
        body: ApiClientMock.fixture(resource_type, 'list.json')
      )
    )
    expect(parser.parse(subject.list.body).count).to eq 2
  end

  it 'returns a list of translatons filtered by locale' do
    allow(api).to receive(:get).with("/projects/#{project_id}/locales/#{locale_id}/translations?page=1&per_page=25").and_return(
      Phraseapp::Rest::Resource::Response.new(
        code: 200,
        body: ApiClientMock.fixture(resource_type, 'list_by_locale.json')
      )
    )
    expect(parser.parse(subject.list_by_locale(locale_id: locale_id).body).count).to eq 2
  end
end
