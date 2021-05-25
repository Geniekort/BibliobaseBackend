module Query::Node::Matcher
  class Exactly < Matcher

    def filter_object(data_object)
      matcher_entries.all? do |matcher_entry|
        object_value = matcher_entry.retrieve_object_value(data_object)
        object_value == matcher_entry.value
      end
    end

    def validate
      super
    end
  end
end
