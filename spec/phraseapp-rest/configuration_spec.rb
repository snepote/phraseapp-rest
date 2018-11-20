# frozen_string_literal: true

require_relative '../../lib/phraseapp-rest/configuration'

RSpec.describe Phraseapp::Rest::Configuration do
  subject { described_class.new }

  it 'raise an exception if a token is not set' do
    expect { subject.token } .to(raise_error 'Phraseapp api token not defined')
  end
end
