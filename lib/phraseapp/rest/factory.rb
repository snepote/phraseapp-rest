# frozen_string_literal: true

require 'rest-client'
require_relative 'api'

module Phraseapp
  module Rest
    class Factory
      def self.api
        Phraseapp::Rest::Api.new(rest_client: RestClient, token: ENV['PHRASEAPP_API_KEY'])
      end
    end
  end
end
