module Types::Input
  class CurateRecord < Types::BaseInputObject
    graphql_name "CurateRecordInput" 

    description "Input data for CurateRecord"

    argument :curation_session_id, ID, required: true
    argument :import_record_id, ID, required: true
    argument :curation_type, String, required: true
    argument :data_object_attributes, GraphQL::Types::JSON, required: false
  end
end
