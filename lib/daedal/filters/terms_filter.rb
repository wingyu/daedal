require 'daedal/filters/base_filter'
require 'daedal/attributes'

module Daedal
  module Filters
    """Class for the basic term filter"""
    class TermsFilter < BaseFilter
  
      # required attributes
      attribute :field, Symbol
      attribute :terms, Array[Symbol]
  
      def to_hash
        {terms: {field => terms}}
      end
    end
  end
end