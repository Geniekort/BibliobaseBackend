module Query::Node::ControlFlow
  class Or < ControlFlow
    # Return true if any child nodes allow this data object
    def filter_object(data_object)
      children.any? do |child_node|
        child_node.filter_object(data_object)
      end
    end
  end
end
