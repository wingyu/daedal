module Daedal
  module Queries
    "" "Class for the basic terms query" ""
    class TermsQuery < Query

      # required attributes
      attribute :field, Daedal::Attributes::Field
      attribute :terms, Array[Daedal::Attributes::QueryValue]

      # not required
      attribute :minimum_should_match, Integer, default: 1, required: false

      def to_hash
         {terms: {field => terms}, minimum_should_match: minimum_should_match}
      end
    end
  end
end