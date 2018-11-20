# frozen_string_literal: true

module Phraseapp
  module Rest
    class Configuration
      attr_writer :token

      def initialize
        @token = nil
      end

      def token
        raise 'Phraseapp api token not defined' if @token.nil?

        @token
      end
    end
  end
end
