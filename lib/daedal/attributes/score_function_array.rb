module Daedal
  module Attributes
    """Custom coercer for the type attribute"""
    class ScoreFunctionArray < Array
      def <<(function)
        raise Virtus::CoercionError.new(value, 'Daedal::Attributes::ScoreFunction') unless valid_score_function?(function)

        super function
      end

      def unshift(function)
        raise Virtus::CoercionError.new(f, 'Daedal::Attributes::ScoreFunctions') unless valid_score_function?(function)

        super function
      end


      # Values should be an array of hashes with filter & weight
      def valid_score_function?(score_function)
        score_function[:filter].respond_to?(:hash) && score_function[:weight].respond_to?(:hash)
      end
    end
  end
end