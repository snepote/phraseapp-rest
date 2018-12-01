# frozen_string_literal: true

require 'time'

module Phraseapp
  module Rest
    module Resource
      module List
        def list(updated_after: nil)
          response = @client.get(@path)
          response.body.delete_if { |i| Time.parse(i[:updated_at]) < updated_after } unless updated_after.nil?
          response
        end
      end
    end
  end
end
