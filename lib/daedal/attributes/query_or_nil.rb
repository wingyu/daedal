module Daedal
  module Attributes
    """Custom coercer for a query, allowing nil"""
    class QueryOrNil < Virtus::Attribute
      def coerce(value)
        unless value.is_a? Daedal::Queries::BaseQuery or value.nil?
          raise "Invalid query"
        end
        value
      end
    end
  end
end