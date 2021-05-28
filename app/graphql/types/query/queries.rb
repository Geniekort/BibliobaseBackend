module Types::Query
  module Queries
    def self.included(child_class)
      child_class.field(
        :execute_query,
        [Types::Object::Data::DataObject],
        null: false,
      ) do
        description "Execute a query"
        argument :queried_data_type_id, GraphQL::Types::ID, required: true
        argument :query_string, String, required: true
      end
    end

    # Execute a query and return its results
    def execute_query(queried_data_type_id:, query_string:)
      queried_data_type = Data::DataType.find(queried_data_type_id)
      query_executor = Query::Executor.new(queried_data_type, query_string)
      query_executor.execute
    end

  end
end
