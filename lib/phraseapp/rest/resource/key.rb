# frozen_string_literal: true

require_relative 'parser'
require_relative 'list'

module Phraseapp
  module Rest
    module Resource
      class Key
        include Parser
        include List

        def initialize(client:, project_id:)
          @client = client
          @path = "/projects/#{project_id}/keys"
        end

        def get(key_id:)
          raise raise "implement me!, key_id=#{key_id}"
        end
      end
    end
  end
end
