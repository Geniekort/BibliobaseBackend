module Query::Node::Matcher
  class Matcher < Query::Node::FilterNode
    def initialize(node_key, context, original_query)
      super(node_key, context, original_query)
      initialize_matcher_entries
    end

    def initialize_matcher_entries
      unless original_query.is_a?(Hash) && !original_query.keys.empty?
        raise Query::InvalidQueryError, "Missing matcher_entries for #{self.class.name.demodulize.downcase}"
      end

      @matcher_entries = original_query.map do |key, value|
        MatcherEntry.new(key, value, context)
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
  end
end
