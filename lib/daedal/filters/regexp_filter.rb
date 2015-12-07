module Daedal
  module Filters
    """Class for the regexp filter"""
    class RegexpFilter < Filter

      # required attributes
      attribute :field,                     Daedal::Attributes::Field
      attribute :query,                     Daedal::Attributes::LowerCaseString

      # non required attributes
      attribute :flags,                     Array[Daedal::Attributes::Flag], required: false

      def to_hash
        result = {regexp: {field => {value: query}}}
        options = set_options
        result[:regexp][field].merge!(options)

        result
      end

      private

      def set_options
        { flags: parse_flags(flags) }.select {|k,v| !v.nil?}
      end

      def parse_flags(flags)
        flags.map(&:to_s).join('|') unless flags.empty?
      end
    end
  end
end
