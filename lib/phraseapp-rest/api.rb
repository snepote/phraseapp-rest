# frozen_string_literal: true

module Phraseapp
  module Rest
    class Api
      BASE_URL = 'https://api.phraseapp.com/api/v2'
      def initialize(rest_client:, token:)
        @client = rest_client
        @token = token
      end

      def get(path)
        rsp, _err = @client::Request.execute(
          url: "#{BASE_URL}#{path}",
          method: :get,
          user: @token,
          content_type: :json, accept: :json, verify_ssl: TRUE
        )
        rsp.body
      rescue @client::ExceptionWithResponse => e
        return '[]' if e.response.code == 404

        raise e
      end
    end
  end
end
