module Types::Input::CurationSession
  class Create < Types::BaseInputObject
    graphql_name "CreateCurationSessionInput"

    description "Input data for CurationSession"

    argument :project_id, ID, required: true
    argument :import_id, ID, required: true
    argument :data_type_id, ID, required: true
    argument :mapping, GraphQL::Types::JSON, required: false
  end
end
