# frozen_string_literal: true

require_relative 'resource/response'
require_relative 'resource/parser'

module Phraseapp
  module Rest
    class Api
      BASE_URL = 'https://api.phraseapp.com/api/v2'
      def initialize(rest_client:, token:, response: Resource::Response.new)
        @client = rest_client
        @token = token
        @response = response
      end

      def get(path)
        rsp, _err = @client::Request.execute(
          url: "#{BASE_URL}#{path}",
          method: :get,
          user: @token,
          content_type: :json, accept: :json, verify_ssl: TRUE
        )
        format(rsp.headers, rsp.code, rsp.body)
      rescue @client::ExceptionWithResponse => e
        return format({}, 404, '[]') if e.response.code == 404

        raise e
      end

      private

      def format(headers, code, body)
        @response.header = headers
        @response.code = code
        @response.body = Phraseapp::Rest::Resource::Parser.parse(body)
        @response
      end
    end
  end
end
