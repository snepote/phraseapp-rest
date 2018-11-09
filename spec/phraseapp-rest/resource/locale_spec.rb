# frozen_string_literal: true

require 'time'
require_relative '../../../lib/phraseapp-rest/resource/locale'
require_relative 'api_client_mock'

RSpec.describe Phraseapp::Rest::Resource::Locale do
  subject { described_class.new(client: api, project_id: project_id) }
  let(:resource_type) { described_class.to_s.split('::').last.downcase }
  let(:project_id) { 'project_id' }
  let(:api) { double('Api') }

  it 'returns a list of two locales' do
    allow(api).to receive(:get).with("/projects/#{project_id}/locales").and_return(
      ApiClientMock.fixture(resource_type, 'list.json')
    )
    expect(subject.list.count).to eq 2
  end

  it 'returns a list of locales updated after a date' do
    allow(api).to receive(:get).with("/projects/#{project_id}/locales").and_return(
      ApiClientMock.fixture(resource_type, 'list.json')
    )
    certain_date = Time.parse('2015-01-28T09:54:53Z')
    expect(subject.list(updated_after: certain_date).count).to eq 1
  end
end
