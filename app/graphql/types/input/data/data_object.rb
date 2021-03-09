module Types::Input::Data
  class DataObject < Types::BaseInputObject
    graphql_name "DataObjectInput"

    description "Input data for DataObject mutations"

    argument :data_type_id, ID, required: true,
      description: "ID of DataType"
    argument :project_id, ID, required: true,
      description: "ID of Project"
    argument :data, GraphQL::Types::JSON, required: true,
      description: "data of this data_object"
  end
end
