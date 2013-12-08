module Daedal
  module Attributes
    """Custom coercer for a filter, allowing nil"""
    class FilterOrNil < Virtus::Attribute
      def coerce(value)
        unless value.is_a? Daedal::Filters::BaseFilter or value.nil?
          raise "Invalid filter"
        end
        value
      end
    end
  end
end