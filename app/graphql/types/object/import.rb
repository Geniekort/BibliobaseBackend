module Types::Object
  class Import < Types::BaseObject
    description "A import"

    field :id, ID, null: false
    field :name, String, null: false
    field :raw_data, String, null: false
    field :meta, GraphQL::Types::JSON, null: true
    field :parsed_data, GraphQL::Types::JSON, null: true

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
