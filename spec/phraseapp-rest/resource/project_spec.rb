# frozen_string_literal: true

require 'time'
require_relative '../../../lib/phraseapp-rest/resource/project'
require_relative 'api_client_mock'

RSpec.describe Phraseapp::Rest::Resource::Project do
  subject { described_class.new(client: api) }
  let(:resource_type) { described_class.to_s.split('::').last.downcase }
  let(:api) { double('Api') }

  it 'returns one project for the given id' do
    allow(api).to receive(:get)
      .with('/projects/abcd1234cdef1234abcd1234cdef1234')
      .and_return(ApiClientMock.resource(resource_type, 'get.json'))
    project = subject.get(id: 'abcd1234cdef1234abcd1234cdef1234').body
    expect(project[:id]).to eq 'abcd1234cdef1234abcd1234cdef1234'
    expect(project[:name]).to eq 'My Android Project'
  end

  it 'returns a list of projects updated after a date' do
    allow(api).to receive(:get)
      .with('/projects')
      .and_return(ApiClientMock.resource(resource_type, 'list.json'))
    certain_date = Time.parse('2015-01-28T09:54:53Z')
    expect(subject.list(updated_after: certain_date).body.count).to eq 1
  end

  it 'returns nothing when project does not exists' do
    allow(api).to receive(:get)
      .with('/projects/non_existing_project')
      .and_return(ApiClientMock.response(body: '[]'))
    expect(subject.get(id: 'non_existing_project').body).to be_empty
  end
end
