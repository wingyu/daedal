module Daedal
  module Filters
    """Class for the geo filter with range abilities"""
    class GeoDistanceRangeFilter < Filter
      POSSIBLE_COMPARE_OPTIONS = %i(gte gt lte lt)

      # required attributes
      attribute :field,         Daedal::Attributes::Field
      attribute :lat,           Float
      attribute :lon,           Float

      # non required attributes
      attribute :unit,          Daedal::Attributes::DistanceUnit, default: 'km'
      POSSIBLE_COMPARE_OPTIONS.each do |possible_compare|
        attribute possible_compare,   Daedal::Attributes::QueryValue, required: false
      end

      def initialize(options={})
        super options
        validate_compare_options(options)
      end

      def to_hash
        {
          geo_distance_range: {
            field =>  {
              lat: lat,
              lon: lon
            }
          }.merge(compare_options)
        }
      end

      private

      def compare_options
        POSSIBLE_COMPARE_OPTIONS.each_with_object({}) do |compare_option, compare_options|
          compare_options[compare_option] = decorate_distance(attributes[compare_option]) if attributes[compare_option]
        end
      end

      def decorate_distance(distance)
        "#{distance}#{unit}"
      end

      def validate_compare_options(options)
        if options.values_at(*POSSIBLE_COMPARE_OPTIONS).compact.empty?
          raise 'Must give at least one of gte, gt, lt, or lte'
        end
        raise 'gte & gt are not valid together' if gte && gt
        raise 'gte & gt are not valid together' if lte && lt
      end
    end
  end
end