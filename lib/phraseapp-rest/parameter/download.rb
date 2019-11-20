# frozen_string_literal: true
require_relative 'base'

module Phraseapp
  module Rest
    module Parameter
      class Download < Base
        FILE_FORMAT = ['simple_json'].freeze

        attr_reader :file_format

        def initialize(file_format: 'simple_json')
          self.file_format = file_format
        end

        def file_format=(format)
          raise "file format #{format} not supported" unless FILE_FORMAT.include?(format)

          @file_format = format
        end

        protected

        def params
          %w(file_format)
        end
      end
    end
  end
end
