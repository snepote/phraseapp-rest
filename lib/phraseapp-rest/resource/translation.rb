# frozen_string_literal: true

require_relative 'page'
require_relative 'parser'

module Phraseapp
  module Rest
    module Resource
      class Translation
        require_relative 'list'

        def initialize(client:, project_id:)
          @client = client
          @path = "/projects/#{project_id}"
        end

        def get(id:)
          Parser.parse(@client.get("#{@path}/translations/#{id}"))
        end

        def list(page: Resource::Page.new)
          path = "#{@path}/translations"
          path += querystring(page: page)
          Parser.parse(@client.get(path))
        end

        def list_by_locale(locale_id:, param: nil, query: nil, page: Resource::Page.new)
          path = "#{@path}/locales/#{locale_id}/translations"
          path += querystring(param: param, query: query, page: page)
          Parser.parse(@client.get(path))
        end

        private

        def querystring(param: nil, query: nil, page:)
          str = [param, query, page].compact.map(&:to_s).join('&')
          "?#{str}" unless str.empty?
        end
      end
    end
  end
end
