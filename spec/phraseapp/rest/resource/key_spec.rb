# frozen_string_literal: true

require_relative '../../../../lib/phraseapp/rest/resource/key'
require_relative 'api_client_mock'

RSpec.describe Phraseapp::Rest::Resource::Key do
  subject { described_class }
  let(:resource_type) { described_class.to_s.split('::').last.downcase }
  let(:project_id) { 'project_id' }
  let(:api) { double('Api') }

  it 'returns a list of two keys' do
    allow(api).to receive(:get).with("/projects/#{project_id}/keys").and_return(
      ApiClientMock.fixture(resource_type, 'list.json')
    )
    expect(subject.new(client: api, project_id: project_id).list.count).to eq 2
  end
end
