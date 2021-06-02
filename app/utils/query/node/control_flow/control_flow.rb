module Query::Node::ControlFlow
  class ControlFlow < Query::Node::FilterNode
    attr_accessor :children

    def initialize(node_key, context, subquery)
      super(node_key, context, subquery)

      @children = subquery.map do |subquery_object|
        subquery_object.map do |key, subquery|
          Query::FilterNodeFactory.parse_node(key, context, subquery)
        end
      end.flatten
    end

    def validate 
      children.each_with_index do |child, index|
        unless child.validate
          add_nested_errors(index, child)
          return false
        end
      end

      super
    end
  end
end
