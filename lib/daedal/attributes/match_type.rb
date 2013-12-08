module Daedal
  module Attributes
    """Custom coercer for the type attribute"""
    class MatchType < Virtus::Attribute
      ALLOWED_MATCH_TYPES = [:phrase, :phrase_prefix]
      def coerce(value)
        unless value.nil?
          value = value.to_sym
          unless ALLOWED_MATCH_TYPES.include? value
            raise "#{value} is not a valid type. Allowed values are #{ALLOWED_MATCH_TYPES}."
          end
        end
        value
      end
    end
  end
end