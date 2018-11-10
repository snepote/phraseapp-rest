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

        def get(id:)
          parse(@client.get("#{@path}/#{id}"))
        end
      end
    end
  end
end
