# frozen_string_literal: true

require 'json'

module Phraseapp
  module Rest
    module Resource
      module Parser
        OPTIONS = { max_nesting: 4, symbolize_names: TRUE, object_class: OpenStruct }.freeze

        def parse(json)
          JSON.parse(json, OPTIONS)
        end
      end
    end
  end
end
