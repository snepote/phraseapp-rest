# frozen_string_literal: true

require_relative 'list'
require_relative 'parser'
require_relative '../parameter/download'

module Phraseapp
  module Rest
    module Resource
      class Locale
        include List

        def initialize(client:, project_id:)
          @client = client
          @path = "/projects/#{project_id}/locales"
        end

        def get(id:)
          Parser.parse(@client.get("#{@path}/#{id}"))
        end

        def download(id:, params: Phraseapp::Rest::Parameter::Download.new)
          path = "#{@path}/#{id}/download"
          path += "?#{params}" unless params.nil?
          @client.get(path)
        end
      end
    end
  end
end
