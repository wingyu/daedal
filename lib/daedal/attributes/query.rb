module Daedal
  module Attributes
    """Custom coercer for a query"""
    class Query < Virtus::Attribute
      def coerce(value)
        unless value.is_a? Daedal::Queries::BaseQuery
          raise "Must give a query"
        end
        value
      end
    end
  end
end