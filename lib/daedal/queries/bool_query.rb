require 'daedal/queries/base_query'
require 'daedal/attributes'

module Daedal
  module Queries
    """Class for the bool query"""
    class BoolQuery < BaseQuery
  
      # required attributes

      # should, must, and must_not must be an array of queries
      # these queries must inherit from the BaseQuery class
      attribute :should, Attributes::QueryArray[Daedal::Queries::BaseQuery], default: Array.new
      attribute :must, Attributes::QueryArray[Daedal::Queries::BaseQuery], default: Array.new
      attribute :must_not, Attributes::QueryArray[Daedal::Queries::BaseQuery], default: Array.new
  
      # non required attributes
      attribute :minimum_should_match, Integer, required: false
      attribute :boost, Integer, required: false
  
      def to_hash
        result = {bool: {should: should.map {|q| q.to_hash}, must: must.map {|q| q.to_hash}, must_not: must_not.map {|q| q.to_hash}}}
        options = {minimum_should_match: minimum_should_match, boost: boost}
        result[:bool].merge!(options.select { |k,v| !v.nil? })
  
        result
      end
    end
  end
end