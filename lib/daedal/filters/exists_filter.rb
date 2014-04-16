module Daedal
  module Filters
    """Class for the basic term filter"""
    class ExistsFilter < Filter
  
      # required attributes
      attribute :field,     Daedal::Attributes::Field

      def to_hash
        {exists: {:field => field}}
      end
    end
  end
end