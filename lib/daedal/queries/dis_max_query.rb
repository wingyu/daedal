require 'daedal/queries/base_query'
require 'daedal/attributes'

module Daedal
  module Queries

    """Class for the basic match query"""
    class DisMaxQuery < BaseQuery
  
      # required attributes
      attribute :queries, Attributes::QueryArray, default: Array.new
  
      # non required attributes
      attribute :tie_breaker, Float, required: false
      attribute :boost, Integer, required: false
  
      def verify_query(q)
        unless q.is_a? Daedal::Queries::BaseQuery
          raise "Must give a valid query"
        end
      end
  
      def add_query(q)
        verify_query(q)
        queries << q
      end
  
      def to_hash
        result = {dis_max: {queries: queries.map {|q| q.to_hash }}}
        options = {tie_breaker: tie_breaker, boost: boost}
        result[:dis_max].merge!(options.select { |k,v| !v.nil? })
  
        result
      end
    end
  end
end