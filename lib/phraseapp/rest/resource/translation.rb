# frozen_string_literal: true

require_relative 'parser'

module Phraseapp
  module Rest
    module Resource
      class Translation
        include Parser
        require_relative 'list'

        def initialize(client:, project_id:)
          @client = client
          @path = "/projects/#{project_id}"
        end

        def get(translation_id:)
          raise "implement me!, translation_id=#{translation_id}"
        end

        def list
          parse(@client.get("#{@path}/translations"))
        end

        def list_by_locale(locale_id: id, param: nil, query: nil)
          path = "#{@path}/locales/#{locale_id}/translations"
          path += querystring(param: param, query: query)
          parse(@client.get(path))
        end

        private

        def querystring(param: nil, query: nil)
          str = [param.to_s, query.to_s].join('&')
          "?#{str}" unless str.empty?
        end
      end
    end
  end
end
