module Types::Object::Audit
  class CurationAction < Types::BaseObject
    description "A curation action"

    field :id, ID, null: false
    field :curation_type, String, null: false
    field :import_record, Types::Object::ImportRecord, null: false
    field :created_data_object, Types::Object::Data::DataObject, null: true

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
