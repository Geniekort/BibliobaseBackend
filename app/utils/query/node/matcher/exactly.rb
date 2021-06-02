module Query::Node::Matcher
  class Exactly < Matcher
    def filter_object(data_object)
      matcher_entries.all? do |matcher_entry|
        object_value = matcher_entry.retrieve_object_value(data_object)
        object_value == matcher_entry.value
      end
    end

    def allowed_matcher_entry_data_attribute_types
      %w[Text Number Reference]
    end

    def allowed_matcher_entry_value_types
      %w[String Integer Float]
    end
  end
end
