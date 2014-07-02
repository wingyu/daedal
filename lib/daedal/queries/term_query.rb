module Daedal
  module Queries
    "" "Class for the basic term query" ""
    class TermQuery < Query

      # required attributes
      attribute :field, Daedal::Attributes::Field

      # non required attributes, but one must be required of the two, and one only
      attribute :term, Daedal::Attributes::QueryValue, required: false
      attribute :value, Daedal::Attributes::QueryValue, required: false

      #non required attributes
      attribute :boost, Daedal::Attributes::Boost, required: false

      def initialize(options={})
        super options

        if value.nil? && term.nil?
          raise "Must give a value or a term"
        elsif value && term
          raise "Use either Value or Term only, but not both"
        elsif value && boost.nil?
          raise "Please specified boost"
        end

      end

      def to_hash
        if boost
          if value
            result = {term: {field => {value: value, boost: boost}}}
          else
            result = {term: {field => {term: term, boost: boost}}}
          end
        else
          result = {term: {field => term}}
        end

        result
      end
    end
  end
end