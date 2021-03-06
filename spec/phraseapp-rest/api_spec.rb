# frozen_string_literal: true

require 'rest-client'
require 'webmock/rspec'
require_relative '../../lib/phraseapp-rest/api'

RSpec.describe Phraseapp::Rest::Api do
  let(:rest_client) { RestClient }
  let(:token) { 'some_random_token' }
  let(:base_url) { 'https://api.phraseapp.com/api/v2' }
  subject { described_class.new(rest_client: rest_client, token: token) }

  describe '.get' do
    it 'returns an empty body when resource is found but without content' do
      stub_request(:get, "#{base_url}/some_path").to_return(status: 200, body: '[]')
      expect(subject.get('/some_path')).to eq '[]'
    end

    it 'returns an empty json array body when resource is not found' do
      stub_request(:get, "#{base_url}/some_wrong_path").to_return(status: 404, body: nil)
      expect(subject.get('/some_wrong_path')).to eq '[]'
    end
  end
end
