# frozen_string_literal: true

require_relative 'list'
require_relative 'parser'

module Phraseapp
  module Rest
    module Resource
      class Key
        include List

        def initialize(client:, project_id:)
          @client = client
          @path = "/projects/#{project_id}/keys"
        end

        def get(id:)
          Parser.parse(@client.get("#{@path}/#{id}"))
        end
      end
    end
  end
end
