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

        def get(project_id:)
          raise "implement me!, project_id=#{project_id}"
        end
      end
    end
  end
end
