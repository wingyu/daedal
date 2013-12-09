module Daedal
  module Attributes
    """Custom attribute for an array of queries"""
    class FilterArray < Array
      # override the << method so that you throw
      # an error if you don't try to append a query
      def <<(f)
        if f.is_a? Daedal::Filters::BaseFilter
          super f
        else
          raise Virtus::CoercionError.new(f, 'Daedal::Filters::BaseFilter')
        end
      end

      def unshift(f)
        if f.is_a? Daedal::Filters::BaseFilter
          super f
        else
          raise Virtus::CoercionError.new(f, 'Daedal::Filters::BaseFilter')
        end
      end
    end
  end
end