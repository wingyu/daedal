require 'virtus'

module Daedal
  module Queries
    class BaseQuery
      include Virtus.model strict: true

      def to_json
        to_hash.to_json
      end
    end
  end
end