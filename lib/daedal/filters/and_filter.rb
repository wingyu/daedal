require 'daedal/filters/base_filter'
require 'daedal/attributes'

module Daedal
  module Filters
    """Class for the basic term filter"""
    class AndFilter < BaseFilter
  
      # required attributes
      attribute :filters, Attributes::FilterArray[BaseFilter]
  
      def to_hash
        {:and => filters.map {|f| f.to_hash}}
      end
    end
  end
end