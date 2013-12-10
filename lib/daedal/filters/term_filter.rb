require 'daedal/filters/filter'
require 'daedal/attributes'

module Daedal
  module Filters
    """Class for the basic term filter"""
    class TermFilter < Filter
  
      # required attributes
      attribute :field, Symbol
      attribute :term, Symbol
  
      def to_hash
        {term: {field => term}}
      end
    end
  end
end