module Daedal
  module Attributes
    """Custom coercer for the value of a type - can be a string or a symbol. If
    it's none of those, raises a coercion error."""
    class TypeValue < Virtus::Attribute
      ALLOWED_QUERY_VALUE_CLASSES = [String, Symbol]
      def coerce(q)
        if !required? and q.nil?
          return q
        elsif ALLOWED_QUERY_VALUE_CLASSES.include? q.class
          return q
        else
          raise Virtus::CoercionError.new(q, self.class)
        end
      end
    end
  end
end
