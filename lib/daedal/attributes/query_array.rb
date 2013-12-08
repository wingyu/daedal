module Daedal
  module Attributes
    """Custom coercer for an array of queries"""
    class QueryArray < Virtus::Attribute
      def coerce(value)
        unless value.is_a? Array
          value = [value]
        end

        value.each do |q|
          unless q.is_a? Daedal::Queries::BaseQuery
            raise "Must give an array of queries"
          end
        end

        value
      end
    end
  end
end