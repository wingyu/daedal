require 'daedal/queries/match_all_query'
require 'daedal/filters/filter'
require 'daedal/queries/query'
require 'daedal/attributes'

module Daedal
  module Queries
    """Class for the filtered query"""
    class FilteredQuery < Query
  
      # required attributes
      attribute :query, Attributes::Query, default: Daedal::Queries::MatchAllQuery.new
      attribute :filter, Attributes::Filter, default: Daedal::Filters::Filter.new
  
      def to_hash
        {filtered: {query: query.to_hash, filter: filter.to_hash}}
      end
    end
  end
end