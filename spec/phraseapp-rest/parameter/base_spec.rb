# frozen_string_literal: true

require_relative '../../../lib/phraseapp-rest/parameter/base'

RSpec.describe Phraseapp::Rest::Parameter::Base do
  subject { described_class }

  it 'raise an exception when invalid date_range is set as updated_at' do
    expect { subject.new.order = 'invalid order' } .to(
      raise_error "'invalid order' is not supported. Please use 'asc' or 'desc'"
    )
  end

  it 'returns a valid and complete query string when all parameters are passed' do
    expect(
      subject.new(
        branch: 'master',
        sort: 'some_attribute',
        order: 'desc'
      ).to_s
    ).to eq 'branch=master&sort=some_attribute&order=desc'
  end
end
