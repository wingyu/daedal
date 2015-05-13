module Daedal
  module Filters
    """Class for the type filter"""
    class TypeFilter < Filter

      # required attributes
      attribute :type, Daedal::Attributes::TypeValue

      def to_hash
        {type: {:value => type}}
      end
    end
  end
end
