module Types::Input
  class CurationSession < Types::BaseInputObject
    graphql_name "CurationSessionInput"

    description "Input data for CurationSession"

    argument :project_id, ID, required: true
    argument :import_id, ID, required: true
    argument :data_type_id, ID, required: true
  end
end
