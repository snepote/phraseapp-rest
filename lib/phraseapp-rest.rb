# frozen_string_literal: true

require_relative 'phraseapp-rest/version'
require_relative 'phraseapp-rest/configuration'
require_relative 'phraseapp-rest/factory'
require_relative 'phraseapp-rest/parameter/base'
require_relative 'phraseapp-rest/query/base'
require_relative 'phraseapp-rest/resource/key'
require_relative 'phraseapp-rest/resource/locale'
require_relative 'phraseapp-rest/resource/project'
require_relative 'phraseapp-rest/resource/translation'

module Phraseapp
  module Rest
    class << self
      attr_accessor :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end    
  end
end
