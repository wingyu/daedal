require 'daedal/queries/base_query'
require 'daedal/attributes'

module Daedal
  module Queries
    """Class for the bool query"""
    class NestedQuery < BaseQuery
  
      # required attributes
      attribute :path, Symbol
      attribute :query, Daedal::Queries::BaseQuery
  
      # non required attributes
      attribute :score_mode, Attributes::ScoreMode, required: false
  
      def to_hash
        result = {nested: {path: path, query: query.to_hash}}
        unless score_mode.nil?
          result[:nested][:score_mode] = score_mode
        end

        result
      end
    end
  end
end