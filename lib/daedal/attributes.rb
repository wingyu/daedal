require 'virtus'
require 'daedal/queries/base_query'
require 'daedal/filters/base_filter'

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

    """Custom coercer for a filter, allowing nil"""
    class FilterOrNil < Virtus::Attribute
      def coerce(value)
        unless value.is_a? Daedal::Filters::BaseFilter or value.nil?
          raise "Invalid filter"
        end
        value
      end
    end

    """Custom coercer for a query"""
    class Query < Virtus::Attribute
      def coerce(value)
        unless value.is_a? Daedal::Queries::BaseQuery
          raise "Must give a query"
        end
        value
      end
    end

    """Custom coercer for a filter"""
    class Filter < Virtus::Attribute
      def coerce(value)
        unless value.is_a? Daedal::Filters::BaseFilter
          raise "Must give a filter"
        end
        value
      end
    end

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

    """Custom coercer for the operator attribute"""
    class Operator < Virtus::Attribute
      ALLOWED_MATCH_OPERATORS = [:or, :and]
      def coerce(value)
        unless value.nil?
          value = value.to_sym
          unless ALLOWED_MATCH_OPERATORS.include? value
            raise "#{value} is not a valid operator. Allowed values are #{ALLOWED_MATCH_OPERATORS}."
          end
        end
        value
      end
    end
  
    """Custom coercer for the type attribute"""
    class MatchType < Virtus::Attribute
      ALLOWED_MATCH_TYPES = [:phrase, :phrase_prefix]
      def coerce(value)
        unless value.nil?
          value = value.to_sym
          unless ALLOWED_MATCH_TYPES.include? value
            raise "#{value} is not a valid type. Allowed values are #{ALLOWED_MATCH_TYPES}."
          end
        end
        value
      end
    end

  end
end