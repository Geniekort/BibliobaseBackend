module Query
  class FilterNodeFactory
    class << self
      def parse_node(node_key, context, subquery_hash)
        raise InvalidQueryError, "Unknown node_key #{node_key}" unless node_class(node_key)

        node_class(node_key).new(node_key, context, subquery_hash)
      end

      private

      # Return the node class corresponding to a specific node key
      def node_class(node_key)
        {
          "and" => Query::Node::ControlFlow::And,
          "or" => Query::Node::ControlFlow::Or,
          "not" => Query::Node::ControlFlow::Not,
          "exactly" => Query::Node::Matcher::Exactly,
          "contains" => Query::Node::Matcher::Contains,
          "atLeast" => Query::Node::Matcher::AtLeast,
          "atMost" => Query::Node::Matcher::AtMost
        }[node_key]
      end
    end
  end
end
