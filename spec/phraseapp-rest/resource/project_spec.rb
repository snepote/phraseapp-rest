# frozen_string_literal: true

require 'time'
require_relative '../../../lib/phraseapp-rest/resource/project'
require_relative 'api_client_mock'

RSpec.describe Phraseapp::Rest::Resource::Project do
  subject { described_class }
  let(:resource_type) { described_class.to_s.split('::').last.downcase }
  let(:api) { double('Api') }

  it 'returns a list of two projects' do
    allow(api).to receive(:get).with('/projects').and_return(
      ApiClientMock.fixture(resource_type, 'list.json')
    )
    expect(subject.new(client: api).list.count).to eq 2
  end

  it 'returns a list of projects updated after a date' do
    allow(api).to receive(:get).with('/projects').and_return(
      ApiClientMock.fixture(resource_type, 'list.json')
    )
    certain_date = Time.parse('2015-01-28T09:54:53Z')
    expect(subject.new(client: api).list(updated_after: certain_date).count).to eq 1
  end
end
