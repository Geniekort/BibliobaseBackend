module Query
  class FilterNodeFactory
    class << self
      def parse_node(node_key, context, subquery_hash)
        node_class(node_key).new(node_key, context, subquery_hash)
      end

      private

      # Return the node class corresponding to a specific node key
      def node_class(node_key)
        {
          "and" => Query::Node::ControlFlow::And,
          "or" => Query::Node::ControlFlow::Or,
          "not" => Query::Node::ControlFlow::Not,
          "exactly" => Query::Node::Matcher::Exactly
        }[node_key]
      end
    end
  end
end
