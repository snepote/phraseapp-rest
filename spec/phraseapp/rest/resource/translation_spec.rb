# frozen_string_literal: true

require 'time'
require_relative '../../../../lib/phraseapp/rest/resource/translation'
require_relative 'api_client_mock'

RSpec.describe Phraseapp::Rest::Resource::Translation do
  subject { described_class }
  let(:resource_type) { described_class.to_s.split('::').last.downcase }
  let(:project_id) { 'project_id' }
  let(:api) { double('Api') }

  it 'returns a list of two translations' do
    allow(api).to receive(:get).with("/projects/#{project_id}/translations").and_return(
      ApiClientMock.fixture(resource_type, 'list.json')
    )
    expect(subject.new(client: api, project_id: project_id).list.count).to eq 2
  end

  #
  # it 'returns nothing where there project or locale does not exists' do
  #   allow(api).to receive(:get).with("/projects/#{project_id}/translations").and_return('{}')
  #   expect(subject.new(client: api, project_id: project_id).list).to be_empty
  # end

  # it 'returns all translations when no time is provided' do
  #   expect(subject.get(locale: 'de_DE').count).to eq 2
  # end
  #
  # it 'returns one translation when only was updated after the time requested' do
  #   translations = subject.get(locale: 'de_DE', updated_after: Time.parse('2018-10-27 12:00:00 +0200'))
  #   expect(translations.count).to eq 1
  #   expect(translations.first['key']).to eq 'some.other.key'
  # end
  #
  # it 'returns nothing when last translation was before now' do
  #   expect(subject.get(locale: 'de_DE', updated_after: Time.now).count).to eq 0
  # end
  #
  # it 'filters time correctly when using different time zones' do
  #   translations = subject.get(locale: 'en_AU', updated_after: Time.parse('2018-10-27 12:00:00 +0200'))
  #   expect(translations.count).to eq 1
  #   expect(translations.first['key']).to eq 'number.one'
  #
  #   translations = subject.get(locale: 'en_AU', updated_after: Time.parse('2018-10-28 05:00:00 +0100'))
  #   expect(translations.count).to eq 0
  # end
end
