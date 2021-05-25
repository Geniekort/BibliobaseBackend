module Query::Node
  class FilterNode < Node

    attr_accessor :original_query

    def initialize(node_key, context, original_query)
      @original_query = original_query

      super(node_key, context)
    end

    # Returns true iff the data_object matches the filter
    def filter_object(data_object)
      raise NotImplementedError
    end
  end
end
