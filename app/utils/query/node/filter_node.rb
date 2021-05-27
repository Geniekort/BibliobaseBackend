module Query::Node
  class FilterNode < Node

    attr_accessor :subquery

    def initialize(node_key, context, subquery)
      @subquery = subquery

      super(node_key, context)
    end

    # Validate whether the node_key actually matches the class
    def validate
      if node_key != valid_node_key
        errors.add(:node_key, :invalid)
        return false
      end

      super
    end

    # Returns true iff the data_object matches the filter
    def filter_object(data_object)
      raise NotImplementedError
    end

    # The valid node key that this node accepts (for validation purposes)
    def valid_node_key
      self.class.name.demodulize.downcase
    end
  end
end
