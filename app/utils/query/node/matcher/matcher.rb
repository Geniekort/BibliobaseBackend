module Query::Node::Matcher
  class Matcher < Query::Node::FilterNode
    def initialize(node_key, context, subquery)
      super(node_key, context, subquery)
      initialize_matcher_entries
    end

    def initialize_matcher_entries
      unless subquery.is_a?(Hash) && !subquery.keys.empty?
        raise Query::InvalidQueryError, "Missing matcher_entries for #{self.class.name.demodulize.downcase}"
      end

      @matcher_entries = subquery.map do |key, value|
        MatcherEntry.new(
          key,
          value,
          context,
          allowed_matcher_entry_data_attribute_types,
          allowed_matcher_entry_value_types
        )
      end
    end

    # The "children" of this matcher are represented as matcher_entries (as array)
    def matcher_entries
      @matcher_entries || []
    end

    def validate
      matcher_entries.each do |matcher_entry|
        unless matcher_entry.validate
          add_nested_errors(:matcher_entries, matcher_entry)
          return false
        end
      end

      super
    end

    def filter_object(data_object)
      matcher_entries.all? do |matcher_entry|
        object_value = matcher_entry.retrieve_object_value(data_object)
        match_value(object_value, matcher_entry.value)
      end
    end

    def match_value(object_value, test_value)
      raise NotImplementedError
    end

    def allowed_matcher_entry_data_attribute_types
      raise NotImplementedError
    end

    def allowed_matcher_entry_value_types
      raise NotImplementedError
    end
  end
end
