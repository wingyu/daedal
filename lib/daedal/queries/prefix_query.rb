module Daedal
  module Queries
    """Class for the prefix query"""
    class PrefixQuery < Query
  
      # required attributes
      attribute :field,     Symbol
      attribute :query,     Daedal::Attributes::LowerCaseString

      # non required attributes
      attribute :boost,     Float, required: false
  
      def to_hash
        result = {prefix: {field => query}}
        options = {boost: boost}
        result[:prefix].merge!(options.select { |k,v| !v.nil? })

        result
      end
    end
  end
end