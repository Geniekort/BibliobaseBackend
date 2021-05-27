module Query
  # Retrieves all the data for a certain query (represented by a node with a context)
  class DataFilter
    class << self
      def filter_data(node)
        potential_objects = node.context.included_data_objects[node.context.queried_data_type.id]

        potential_objects.select do |data_object|
          node.filter_object(data_object)
        end
      end
    end
  end
end
