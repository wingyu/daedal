module Daedal
  module Filters
    """Class for the basic term filter"""
    class TermsFilter < Filter
  
      # required attributes
      attribute :field,     Daedal::Attributes::Field
      attribute :terms,     Array[Daedal::Attributes::QueryValue]

      # not required
      attribute :execution, Daedal::Attributes::QueryValue, required: false
  
      def to_hash
        result = {terms: {field => terms}}
        unless execution.nil?
          result[:terms][:execution] = execution
        end
        result
      end
    end
  end
end