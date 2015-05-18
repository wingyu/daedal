module Daedal
  module Attributes
    """Custom coercer for the flag attribute"""
    class Flag < Virtus::Attribute
      ALLOWED_FLAGS = [
        :all,
        :none,
        :and,
        :or,
        :not,
        :prefix,
        :phrase,
        :precedence,
        :escape,
        :whitespace,
        :fuzzy,
        :near,
        :slop
      ]

      def coerce(value)
        unless value.nil?
          value = value.to_sym
          unless ALLOWED_FLAGS.include? value
            raise Virtus::CoercionError.new(value, 'Daedal::Attributes::Flag')
          end
        end
        value
      end
    end
  end
end

