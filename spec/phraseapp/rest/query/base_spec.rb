# frozen_string_literal: true

require_relative '../../../../lib/phraseapp/rest/query/base'

RSpec.describe Phraseapp::Rest::Query::Base do
  subject { described_class }

  it 'raise an exception when invalid date_range is set as updated_at' do
    expect { subject.new.updated_at = 'invalid date range' } .to(
      raise_error 'updated_at must be of format {>=|<=}2013-02-21T00:00:00Z'
    )
  end

  it 'returns a valid and complete query string when all parameters are passed' do
    querystring  = 'q=id:some_random_id%20tags:nice%2Ccool%2Cmusic%20unverified:false'
    querystring += '%20excluded:true%20updated_at:%3E%3D2013-02-21T00%3A00%3A00Z'
    expect(
      subject.new(
        id: 'some_random_id',
        tags: 'nice,cool,music',
        unverified: false,
        excluded: TRUE,
        updated_at: '>=2013-02-21T00:00:00Z'
      ).to_s
    ).to eq querystring
  end
end
