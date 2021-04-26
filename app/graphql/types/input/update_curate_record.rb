module Types::Input
  class UpdateCurateRecord < Types::BaseInputObject
    graphql_name "UpdateCurateRecordInput" 

    description "Input data for UpdateCurateRecord"

    argument :curation_type, String, required: false
    argument :data_object_data, GraphQL::Types::JSON, required: false
  end
end
