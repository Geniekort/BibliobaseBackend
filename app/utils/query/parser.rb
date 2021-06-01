module Query
  # Parses a query, returns a fully initialized Query consisting of Nodes,
  #  with a Context.
  class Parser
    class << self
      # @return Node A Node being the Root of the query tree that is obtained
      #               from parsing the query_string
      def parse_query(data_type, query_string)
        context = Query::Context.new(data_type.project, data_type)
        query_object = parse_to_object(query_string)

        if query_object.is_a? Array
          return Query::FilterNodeFactory.parse_node("and", context, query_object)
        elsif query_object.keys.size > 1
          return Query::FilterNodeFactory.parse_node("and", context, [query_object])
        elsif query_object.keys.size == 1
          first_node_key = query_object.keys.first
          return Query::FilterNodeFactory.parse_node(first_node_key, context, query_object[first_node_key])
        end

        nil
      end

      def parse_to_object(query_string)
        return [] unless query_string.present?

        JSON.parse(query_string)
      rescue JSON::ParserError => e
        raise Query::InvalidQueryError, ["Invalid json provided", e]
      end
    end
  end
end
