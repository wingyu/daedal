module Daedal
  module Filters
    class NotFilter < Filter

      # required attributes
      attribute :filter, Daedal::Attributes::Filter

      def to_hash
        {:not => filter.to_hash}
      end
    end
  end
end
