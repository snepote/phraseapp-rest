# frozen_string_literal: true

module ApiClientMock
  def self.fixture(resource_type, filename)
    File.read(File.join(File.dirname(__FILE__), 'fixtures', resource_type, filename))
  end
end
