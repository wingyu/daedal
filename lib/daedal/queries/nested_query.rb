require 'daedal/queries/query'
require 'daedal/attributes'

module Daedal
  module Queries
    """Class for the bool query"""
    class NestedQuery < Query
  
      # required attributes
      attribute :path, Symbol
      attribute :query, Attributes::Query
  
      # non required attributes
      attribute :score_mode, Attributes::ScoreMode, required: false
      attribute :name, Symbol, required: false
  
      def to_hash
        result = {nested: {path: path, query: query.to_hash}}
        options = {score_mode: score_mode, _name: name}
        result[:nested].merge!(options.select { |k,v| !v.nil? })

        result
      end
    end
  end
end