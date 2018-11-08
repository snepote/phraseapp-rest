# frozen_string_literal: true

module Phraseapp
  module Rest
    module Parameter
      class Base
        attr_accessor :branch, :sort
        attr_reader :order

        def initialize(branch: nil, sort: nil, order: nil)
          @branch = branch unless branch.nil?
          @sort = sort unless sort.nil?
          self.order = order unless order.nil?
        end

        def order=(str)
          message = "'#{str}' is not supported. Please use 'asc' or 'desc'"
          raise message unless %w(asc desc).include?(str)

          @order = str
        end

        def to_s
          hash = {}
          %w(branch sort order).each do |attr|
            hash[attr.to_sym] = send(attr) unless send(attr).nil?
          end
          hash.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join('&').to_s
        end
      end
    end
  end
end
