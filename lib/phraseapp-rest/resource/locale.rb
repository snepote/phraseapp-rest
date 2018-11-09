# frozen_string_literal: true

require_relative 'parser'

module Phraseapp
  module Rest
    module Resource
      class Locale
        include Parser

        def initialize(client:, project_id:)
          @client = client
          @path = "/projects/#{project_id}/locales"
        end

        def get(locale_id:)
          raise "implement me!, locale_id=#{locale_id}"
        end

        def list
          parse(@client.get(@path))
        end
      end
    end
  end
end
