require 'daedal/queries/base_query'
require 'daedal/attributes'

module Daedal
  module Queries

    """Class for the dis max query"""
    class DisMaxQuery < BaseQuery
  
      # required attributes
      attribute :queries, Attributes::QueryArray, default: Array.new
  
      # non required attributes
      attribute :tie_breaker, Float, required: false
      attribute :boost, Integer, required: false
      attribute :name, Symbol, required: false
  
      def to_hash
        result = {dis_max: {queries: queries.map {|q| q.to_hash }}}
        options = {tie_breaker: tie_breaker, boost: boost, _name: name}
        result[:dis_max].merge!(options.select { |k,v| !v.nil? })
  
        result
      end
    end
  end
end