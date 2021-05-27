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
  end
end
