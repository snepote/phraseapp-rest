# frozen_string_literal: true

module Phraseapp
  module Rest
    class Api
      BASE_URL = 'https://api.phraseapp.com/api/v2'
      def initialize(rest_client: client, token: access_token)
        @client = rest_client
        @token = token
      end

      def get(path)
        response @client::Request.execute(
          url: "#{BASE_URL}#{path}",
          method: :get,
          user: @token,
          verify_ssl: TRUE
        )
      end

      private

      def response(call)
        rsp, err = call
        raise err.inspect if err

        rsp
      end
    end
  end
end
