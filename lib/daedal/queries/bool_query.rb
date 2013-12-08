require 'daedal/queries/base_query'
require 'daedal/attributes'

module Daedal
  module Queries
    """Class for the bool query"""
    class BoolQuery < BaseQuery
  
      # required attributes

      # should, must, and must_not must be an array of queries
      # these queries must inherit from the BaseQuery class
      attribute :should, Attributes::QueryArray, default: Array.new
      attribute :must, Attributes::QueryArray, default: Array.new
      attribute :must_not, Attributes::QueryArray, default: Array.new
  
      # non required attributes
      attribute :minimum_should_match, Integer, required: false
      attribute :boost, Integer, required: false
  
      def verify_query(q)
        # raises an error if q is not a BaseQuery object
        unless q.is_a? Daedal::Queries::BaseQuery
          raise "Must give a valid query"
        end
      end

      """Virtus models do not perform data type coercion after
      initialization. These methods allow us to add more queries
      to the query arrays after verifying that they are valid

      TODO: define Attributes::QueryArray#<< to do this instead so that
      you can say bool_query.should << q, and the type coercion will happen there instead"""  
      def add_should_query(q)
        verify_query(q)
        should << q
      end
  
      def add_must_query(q)
        verify_query(q)
        must << q
      end
  
      def add_must_not_query(q)
        verify_query(q)
        must_not << q
      end
  
      def to_hash
        result = {bool: {should: should.map {|q| q.to_hash}, must: must.map {|q| q.to_hash}, must_not: must_not.map {|q| q.to_hash}}}
        options = {minimum_should_match: minimum_should_match, boost: boost}
        result[:bool].merge!(options.select { |k,v| !v.nil? })
  
        result
      end
    end
  end
end