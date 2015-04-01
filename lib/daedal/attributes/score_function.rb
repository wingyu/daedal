module Daedal
  module Attributes
    """Custom coercer for the type attribute"""
    class ScoreFunction < Virtus::Attribute

      def coerce(score_functions)
        return unless score_functions


        score_functions
      end

      private

    end
  end
end