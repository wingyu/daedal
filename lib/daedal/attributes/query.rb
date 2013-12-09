module Daedal
  module Attributes
    class Query < Virtus::Attribute
      def coerce(q)
        unless q.is_a? Daedal::Queries::BaseQuery or !required? && q.nil?
          raise Virtus::CoercionError.new(q, 'Daedal::Queries::BaseQuery')
        end

        q
      end
    end
  end
end