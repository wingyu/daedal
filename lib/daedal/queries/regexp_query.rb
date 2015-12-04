module Daedal
  module Queries
    """Class for the prefix query"""
    class RegexpQuery < Query
  
      # required attributes
      attribute :field,     Daedal::Attributes::Field
      attribute :query,     Daedal::Attributes::LowerCaseString

      # non required attributes
      attribute :boost,     Daedal::Attributes::Boost, required: false
      #other attributes and tests
   
      def to_hash
        result = {regexp: {field => query}}
        unless boost.nil?
          result[:regexp][:boost] = boost
        end

        result
      end
    end
  end
end
