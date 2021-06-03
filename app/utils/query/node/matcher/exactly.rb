module Query::Node::Matcher
  class Exactly < Matcher
    def match_value(object_value, test_value)
      object_value == test_value
    end

    def allowed_matcher_entry_data_attribute_types
      %w[Text Number Reference]
    end

    def allowed_matcher_entry_value_types
      %w[String Integer Float]
    end
  end
end
