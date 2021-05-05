module Types::Object
  class ImportRecord < Types::BaseObject
    description "A import"

    field :id, ID, null: false
    field :data, GraphQL::Types::JSON, null: true
    field :status, String, null: true

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    
  end
end
