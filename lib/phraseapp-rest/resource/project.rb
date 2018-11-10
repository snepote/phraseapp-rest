# frozen_string_literal: true

require_relative 'parser'
require_relative 'list'

module Phraseapp
  module Rest
    module Resource
      class Project
        include Parser
        include List

        def initialize(client:)
          @client = client
          @path = '/projects'
        end

        def get(id:)
          parse(@client.get("#{@path}/#{id}"))
        end
      end
    end
  end
end
