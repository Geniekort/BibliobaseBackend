module Query
  # Takes in a query string, a project and a data type, and finds all objects
  #  of that data type that match the query string
  class Executor
    def initialize(project, data_type, query_string)
      @project = project
      @data_type = data_type
      @query_string = query_string
    end

    def parse_query

    end

    def prepare_query

    end
  end
end
