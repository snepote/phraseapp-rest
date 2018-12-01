# frozen_string_literal: true

require_relative '../../../lib/phraseapp-rest/resource/translation'
require_relative 'api_client_mock'

RSpec.describe Phraseapp::Rest::Resource::Translation do
  subject { described_class.new(client: api, project_id: project_id) }
  let(:resource_type) { described_class.to_s.split('::').last.downcase }
  let(:project_id) { 'project_id' }
  let(:locale_id) { 'locale_id' }
  let(:api) { double('Api') }

  it 'returns one translation for the given id' do
    allow(api).to receive(:get)
      .with("/projects/#{project_id}/translations/abcd1234cdef1234abcd1234cdef1234")
      .and_return(ApiClientMock.fixture(resource_type, 'get.json'))
    translation = subject.get(id: 'abcd1234cdef1234abcd1234cdef1234')
    expect(translation[:id]).to eq 'abcd1234cdef1234abcd1234cdef1234'
    expect(translation[:content]).to eq 'My translation'
  end

  it 'returns a list of two translations' do
    allow(api).to receive(:get).with("/projects/#{project_id}/translations?page=1&per_page=25")
                               .and_return(ApiClientMock.fixture(resource_type, 'list.json'))
    expect(subject.list.count).to eq 2
  end

  it 'returns a list of translatons filtered by locale' do
    allow(api).to receive(:get)
      .with("/projects/#{project_id}/locales/#{locale_id}/translations?page=1&per_page=25")
      .and_return(ApiClientMock.fixture(resource_type, 'list_by_locale.json'))
    expect(subject.list_by_locale(locale_id: locale_id).count).to eq 2
  end
end
