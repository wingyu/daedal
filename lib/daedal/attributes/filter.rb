module Daedal
  module Attributes
    """Custom coercer for a filter"""
    class Filter < Virtus::Attribute
      def coerce(value)
        unless value.is_a? Daedal::Filters::BaseFilter
          raise "Must give a filter"
        end
        value
      end
    end
  end
end