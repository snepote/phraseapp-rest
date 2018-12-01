# frozen_string_literal: true

require 'time'
require_relative 'page'
require_relative 'parser'

module Phraseapp
  module Rest
    module Resource
      module List
        def list(updated_after: nil, page: nil)
          path = @path + ("&#{page}" unless page.nil?).to_s
          items = Parser.parse(@client.get(path))
          items = remove(items, updated_after) unless updated_after.nil?
          items
        end

        private

        def remove(items, updated_after)
          items.delete_if { |i| Time.parse(i[:updated_at]) < updated_after }
        end
      end
    end
  end
end
