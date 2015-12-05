module Daedal
  module Queries
    """Class for the regexp query"""
    class RegexpQuery < Query

      # required attributes
      attribute :field,                     Daedal::Attributes::Field
      attribute :query,                     Daedal::Attributes::LowerCaseString

      # non required attributes
      attribute :boost,                     Daedal::Attributes::Boost, required: false
      attribute :flags,                     Array[Daedal::Attributes::Flag], required: false
      attribute :max_determinized_states,   Integer, required: false

      def to_hash
        result = {regexp: {field => {value: query}}}
        options = set_options
        result[:regexp][field].merge!(options)

        result
      end

      private

      def set_options
        {
          boost: boost,
          flags: parse_flags(flags),
          max_determinized_states: max_determinized_states,
        }.select {|k,v| !v.nil?}
      end

      def parse_flags(flags)
        flags.map(&:to_s).join('|') unless flags.empty?
      end
    end
  end
end
