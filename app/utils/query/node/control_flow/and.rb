module Query::Node::ControlFlow
  class And < ControlFlow
    # Only return true if all child nodes allow this data object
    def filter_object(data_object)
      children.all? do |child_node|
        child_node.filter_object(data_object)
      end
    end
  end
end
