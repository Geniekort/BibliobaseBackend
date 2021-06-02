module Query
  # Takes in a query string and a data type, and finds all objects
  #  of that data type that match the query string
  class Executor
    def initialize(data_type, query_string)
      @data_type = data_type
      @query_string = query_string
    end

    # Executes a query by taking the following steps:
    # - Parse the query
    # - Retrieve potentially relevant data from the DB
    # - Filter all data to return the matching records
    def execute
      query_root_node = Query::Parser.parse_query @data_type, @query_string

      raise Query::InvalidQueryError, query_root_node.errors.messages unless query_root_node.validate

      Query::DataRetriever.retrieve_data(query_root_node)
      Query::DataFilter.filter_data(query_root_node)
    end
  end
end
