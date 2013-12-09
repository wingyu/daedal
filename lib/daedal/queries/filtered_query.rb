require 'daedal/queries/match_all_query'
require 'daedal/filters/base_filter'
require 'daedal/queries/base_query'
require 'daedal/attributes'

module Daedal
  module Queries
    """Class for the filtered query"""
    class FilteredQuery < BaseQuery
  
      # required attributes
      attribute :query, Attributes::Query, default: Daedal::Queries::MatchAllQuery.new
      attribute :filter, Attributes::Filter, default: Daedal::Filters::BaseFilter.new
  
      def to_hash
        {filtered: {query: query.to_hash, filter: filter.to_hash}}
      end
    end
  end
end