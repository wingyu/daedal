require 'daedal/filters/base_filter'

module Daedal
  module Filters
    """Class for the basic term filter"""
    class RangeFilter < BaseFilter
  
      # required attributes
      attribute :field, Symbol
      attribute :gte
      attribute :lte
      attribute :gt
      attribute :lt

      def initialize(options={})
        super options
        unless !gte.nil? or !gt.nil? or !lt.nil? or !lte.nil?
          raise "Must give at least one of gte, gt, lt, or lte"
        end
      end
  
      def to_hash
        {range: {field => {gte: gte, lte: lte, lt: lt, gt: gt}.select {|k,v| !v.nil?}}}
      end
    end
  end
end