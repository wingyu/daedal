require 'daedal/queries/base_query'

module Daedal
  module Queries
    """Class for the basic match query"""
    class MatchAllQuery < BaseQuery
      def to_hash
        {match_all: {}}
      end
    end
  end
end