# frozen_string_literal: true

module Phraseapp
  module Rest
    module Resource
      class Page
        def initialize(number: 1, size: 25)
          @number = number
          @size = size
        end

        def to_s
          "page=#{@number.to_s}&per_page=#{@size}"
        end
      end
    end
  end
end
