module Query::Node
  class Node
    attr_accessor :query_hash, :context, :node_key

    def initialize(query_hash, context, node_key)
      @query_hash = query_hash
      @context = context
      @node_key = node_key
    end

    # Validate whether this node was given correct information (query_hash, context and node key)
    def validate
      return true
    end

    # Returns true iff the data_object matches the filter
    def filter_object(data_object)
      raise NotImplementedError
    end
  end
end
