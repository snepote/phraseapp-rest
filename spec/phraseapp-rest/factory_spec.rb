# frozen_string_literal: true

require_relative '../../lib/phraseapp-rest/factory.rb'

RSpec.describe Phraseapp::Rest::Factory do
  subject { described_class }

  it 'returns an Api' do
    expect(subject.api).to be_a Phraseapp::Rest::Api
  end
end
