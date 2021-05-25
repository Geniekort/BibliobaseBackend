module Query::Node::ControlFlow
  class ControlFlow < Query::Node::FilterNode
    attr_accessor :children

    def initialize(query_hash, context, node_key)
      super(query_hash, context, node_key)
    end
  end  
end
