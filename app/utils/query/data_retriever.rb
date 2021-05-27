module Query
  # Retrieves all the data for a certain query (represented by a node with a context)
  class DataRetriever
    class << self
      def retrieve_data(node)
        context = node.context
        context.included_data_objects = {
          context.queried_data_type.id => context.queried_data_type.data_objects
        }

        # TODO
        #  - Include "nested"  data objects as well
        #  - Prefilter data_objects instead of selecting all of them
      end
    end
  end
end
