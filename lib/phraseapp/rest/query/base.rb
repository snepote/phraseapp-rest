# frozen_string_literal: true

require 'uri'
require 'time'

module Phraseapp
  module Rest
    module Query
      class Base
        attr_accessor :id, :tags
        attr_reader :unverified, :excluded, :updated_at

        def initialize(id: nil, tags: nil, unverified: nil, excluded: nil, updated_at: nil)
          @id = id
          @tags = tags
          self.unverified = unverified unless unverified.nil?
          self.excluded = excluded unless excluded.nil?
          self.updated_at = updated_at unless updated_at.nil?
        end

        def unverified=(bool)
          @unverified = set bool
        end

        def excluded=(bool)
          @excluded = set bool
        end

        def updated_at=(date_range)
          # validates that date format is ISO8601
          regex = /[<=>]+[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}(Z|((\+|\-)[0-9]{2}:[0-9]{2}))+/
          error_message = ArgumentError.new 'updated_at must be of format {>=|<=}2013-02-21T00:00:00Z'
          raise error_message if date_range.nil? || date_range.match(regex).nil?

          @updated_at = date_range
        end

        def to_s
          hash = {}
          %w(id tags unverified excluded updated_at).each do |attr|
            hash[attr.to_sym] = URI.encode_www_form_component(send(attr)) unless send(attr).nil?
          end
          'q=' + hash.to_a.map { |x| "#{x[0]}:#{x[1]}" }.join('%20').to_s unless hash.empty?
        end

        private

        def set(bool)
          message = "#{caller(1..1).first} error '#{bool}' is not supported. Please use TRUE or FALSE"
          raise message unless [true, false].include? bool

          bool.to_s
        end
      end
    end
  end
end
