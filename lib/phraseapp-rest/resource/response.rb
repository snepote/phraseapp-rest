# frozen_string_literal: true

module Phraseapp
  module Rest
    module Resource
      class Response
        attr_accessor :code, :header, :body

        def initialize(code: nil, header: nil, body: nil)
          @code = code unless code.nil?
          @header = header unless header.nil?
          @body = body unless body.nil?
        end
      end
    end
  end
end
