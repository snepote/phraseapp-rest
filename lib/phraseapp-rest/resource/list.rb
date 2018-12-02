# frozen_string_literal: true

require 'time'
require_relative 'page'
require_relative 'parser'

module Phraseapp
  module Rest
    module Resource
      module List
        def list(updated_after: nil, names: [], page: nil)
          path = @path + ("&#{page}" unless page.nil?).to_s
          items = Parser.parse(@client.get(path))
          items = remove_when(items, updated_after) unless updated_after.nil?
          items = filter_by(items, names) unless names.empty?
          items
        end

        private

        def remove_when(items, updated_after)
          items.delete_if { |i| Time.parse(i[:updated_at]) < updated_after }
        end

        def filter_by(items, names)
          names = [names] unless names.is_a? Array
          items.delete_if { |i| !names.include? i[:name] }
        end
      end
    end
  end
end
