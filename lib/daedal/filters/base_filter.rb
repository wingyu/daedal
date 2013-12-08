require 'virtus'

module Daedal
  module Filters
    class BaseFilter
      include Virtus.model strict: true

      def to_hash
        {}
      end

      def to_json
        to_hash.to_json
      end
    end
  end
end