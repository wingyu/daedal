module Daedal
  module Queries
    """Class for the simple query string query"""
    class SimpleQueryStringQuery < Query

      # required attributes
      attribute :query,                         String

      # non required attributes
      attribute :default_field,                 Daedal::Attributes::Field, required: false
      attribute :fields,                        Array[Daedal::Attributes::Field], required: false
      attribute :default_operator,              String, required: false
      attribute :analyzer,                      Symbol, required: false
      attribute :lowercase_expanded_terms,      Boolean, required: false
      attribute :minimum_should_match,          Integer, required: false
      attribute :lenient,                       Boolean, required: false
      attribute :flags,                         Array[Daedal::Attributes::Flag], required: false

      def to_hash
        parameters = present_attributes

        if parameters[:flags]
          parameters[:flags] = parameters[:flags].map(&:to_s).join('|')
        end

        { simple_query_string: parameters }
      end

      private

      def present_attributes
        attributes.select do |parameter, value|
          case parameter
          when :fields, :flags
            !value.empty?
          else
            !value.nil?
          end
        end
      end
    end
  end
end
