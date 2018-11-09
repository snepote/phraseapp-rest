# frozen_string_literal: true

require_relative 'parser'
require_relative 'list'

module Phraseapp
  module Rest
    module Resource
      class Locale
        include Parser
        include List

        def initialize(client:, project_id:)
          @client = client
          @path = "/projects/#{project_id}/locales"
        end

        def get(locale_id:)
          raise "implement me!, locale_id=#{locale_id}"
        end
      end
    end
  end
end
