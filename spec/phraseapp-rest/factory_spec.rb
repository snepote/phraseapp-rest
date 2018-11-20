# frozen_string_literal: true

require_relative '../../lib/phraseapp-rest'

RSpec.describe Phraseapp::Rest::Factory do
  subject { described_class }
  let(:config) { double('Phraseapp::Rest::Configuration') }

  it 'returns an Api' do
    # allow(config).to receive(:get).and_return('SOME_PHEASEAPP_TOKEN')
    Phraseapp::Rest.configure do |config|
      config.token = 'SOME_PHEASEAPP_TOKEN'
    end
    expect(subject.api).to be_a Phraseapp::Rest::Api
  end
end
