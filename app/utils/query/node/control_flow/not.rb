module Query::Node::ControlFlow
  class Not < ControlFlow
    # Return true if any child nodes allow this data object
    def filter_object(data_object)
      !children.all? do |child_node|
        child_node.filter_object(data_object)
      end
    end
  end
end
