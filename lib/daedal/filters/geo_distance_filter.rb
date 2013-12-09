require 'daedal/filters/base_filter'
require 'daedal/attributes'

module Daedal
  module Filters
    """Class for the basic term filter"""
    class GeoDistanceFilter < BaseFilter
  
      # required attributes
      attribute :field, Symbol
      attribute :lat, Float
      attribute :lon, Float
      attribute :distance, Float

      # non required attributes
      attribute :unit, Attributes::DistanceUnit, default: 'km'
  
      def full_distance
        "#{distance}#{unit}"
      end

      def to_hash
        {geo_distance: {distance: full_distance, field => {lat: lat, lon: lon}}}
      end
    end
  end
end