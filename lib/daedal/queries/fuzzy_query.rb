module Daedal
  module Queries
    """Class for the fuzzy query"""
    class FuzzyQuery < Query

      # required attributes
      attribute :field,           Daedal::Attributes::Field
      attribute :query,           Daedal::Attributes::QueryValue

      # non required attributes
      attribute :boost,           Float,                          required: false
      attribute :min_similarity,  Daedal::Attributes::QueryValue, required: false
      attribute :prefix_length,   Integer,                        required: false
  
      def to_hash
        result = {fuzzy: {field => {value: query}}}
        options = {boost: boost, min_similarity: min_similarity, prefix_length: prefix_length}.select {|k,v| !v.nil?}
        result[:fuzzy][field].merge!(options)

        result
      end
    end
  end
end