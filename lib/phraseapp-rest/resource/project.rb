# frozen_string_literal: true

require_relative 'list'
require_relative 'parser'

module Phraseapp
  module Rest
    module Resource
      class Project
        include List

        def initialize(client:)
          @client = client
          @path = '/projects'
        end

        def get(id:)
          Parser.parse(@client.get("#{@path}/#{id}"))
        end
      end
    end
  end
end
