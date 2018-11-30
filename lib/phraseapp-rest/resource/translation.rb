# frozen_string_literal: true

require_relative 'page'

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
          @client.get("#{@path}/translations/#{id}")
        end

        def list(page: Resource::Page.new)
          path = "#{@path}/translations"
          path += querystring(page: page)
          @client.get(path)
        end

        def list_by_locale(locale_id:, param: nil, query: nil, page: Resource::Page.new)
          path = "#{@path}/locales/#{locale_id}/translations"
          path += querystring(param: param, query: query, page: page)
          @client.get(path)
        end

        private

        def querystring(param: nil, query: nil, page: page)
          str = [param, query, page].compact.map do |param|
            param.to_s
          end.join('&')
          "?#{str}" unless str.empty?
        end
      end
    end
  end
end
