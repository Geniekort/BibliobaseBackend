module Query
  # Contains all relevant data for a query
  class Context
    attr_accessor :queried_data_type, :project
    attr_accessor :included_data_types
    attr_accessor :included_data_objects

    def initialize(project, queried_data_type)
      @project = project
      @queried_data_type = queried_data_type
    end
  end
end
