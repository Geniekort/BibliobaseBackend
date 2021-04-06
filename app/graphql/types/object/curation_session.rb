module Types::Object
  class CurationSession < Types::BaseObject
    description "A curation session"

    field :id, ID, null: false
    field :data_type, Types::Object::Data::DataType, null: false
    field :project, Types::Object::Project, null: false
    field :import, Types::Object::Import, null: false
    field :started_by, Types::Object::User, null: false

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
