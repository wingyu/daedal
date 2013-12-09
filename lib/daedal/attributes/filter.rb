module Daedal
  module Attributes
    class Filter < Virtus::Attribute
      def coerce(f)
        unless f.is_a? Daedal::Filters::BaseFilter or !required? && f.nil?
          raise Virtus::CoercionError.new(f, 'Daedal::Filters::BaseFilter')
        end

        f
      end
    end
  end
end