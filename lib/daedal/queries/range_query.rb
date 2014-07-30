module Daedal
  module Queries
    "" "Class for range query" ""
    class RangeQuery < Query

      # required attributes
      attribute :field, Daedal::Attributes::Field

      # non required attributes, but at least one must be given
      MINIMUM_ATTRIBUTES = [:gte, :gt, :lte, :lt].sort
      MINIMUM_ATTRIBUTES.each { |a| attribute a, Daedal::Attributes::QueryValue, required: false }

      #non required attributes
      attribute :boost, Daedal::Attributes::Boost, required: false

      def initialize(options={})
        super options

        # ensure at least one of the minimum attributes is provided
        raise "Must give at least one of the following: #{MINIMUM_ATTRIBUTES.join(', ')}" unless (attributes.reject { |k,v| v.nil? }.keys & MINIMUM_ATTRIBUTES).length > 0

      end

      def to_hash
        inner_result = attributes.select { |k,v| MINIMUM_ATTRIBUTES.include?(k) && !v.nil? }
        inner_result.merge(boost: boost) if boost
        
        {range: {field => inner_result} }

      end
    end
  end
end