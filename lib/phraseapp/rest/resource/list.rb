# frozen_string_literal: true

module Phraseapp
  module Rest
    module Resource
      module List
        def list
          parse(@client.get(@path))
        end
      end
    end
  end
end
