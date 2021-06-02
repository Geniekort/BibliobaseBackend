module Query::Node::Matcher
  class Contains < Matcher
    def filter_object(data_object)
      matcher_entries.all? do |matcher_entry|
        object_value = matcher_entry.retrieve_object_value(data_object)
        object_value.to_s.include? matcher_entry.value.to_s
      end
    end

    def allowed_matcher_entry_data_attribute_types
      ["Text"]
    end

    def allowed_matcher_entry_value_types
      ["String"]
    end
  end
end
