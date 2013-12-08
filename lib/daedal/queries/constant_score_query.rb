require 'daedal/queries/base_query'
require 'daedal/attributes'

module Daedal
  module Queries
    """Class for the constant score query"""
    class ConstantScoreQuery < BaseQuery

      # required attributes
      attribute :boost, Float

      # non required attributes, but one must be required of the two

      # TODO: Figure out how to use Virtus Attributes correctly,
      # I shouldn't have to ahve this 'orNil' version hanging around
      attribute :query, Attributes::QueryOrNil
      attribute :filter, Attributes::FilterOrNil

      # you must require *one of* query or filter in order for this to be valid
      def initialize(options={})
        super options
        if query.nil? && filter.nil?
          raise "Must give a query or a filter"
        end
      end
  
      def to_hash
        result = {constant_score: {boost: boost}}
        if !query.nil?
          result[:constant_score][:query] = query.to_hash
        elsif !filter.nil?
          result[:constant_score][:filter] = filter.to_hash
        end

        result
      end
    end
  end
end