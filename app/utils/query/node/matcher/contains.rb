module Query::Node::Matcher
  class Contains < Matcher
    def match_value(object_value, test_value)
      object_value.to_s.include?(test_value.to_s)
    end

    def allowed_matcher_entry_data_attribute_types
      ["Text"]
    end

    def allowed_matcher_entry_value_types
      ["String"]
    end
  end
end
