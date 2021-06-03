module Query::Node::Matcher
  class AtMost < Matcher
    def match_value(object_value, test_value)
      object_value <= test_value
    end

    def allowed_matcher_entry_data_attribute_types
      ["Number"]
    end

    def allowed_matcher_entry_value_types
      %w[Integer Float]
    end
  end
end
