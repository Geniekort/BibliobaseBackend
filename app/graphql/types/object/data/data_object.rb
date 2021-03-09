module Types::Object::Data
  class DataObject < Types::BaseObject
    description "A data object"

    field :id, ID, null: false
    field :data, GraphQL::Types::JSON, null: false
    field :data_type, Types::Object::Data::DataType, null: false

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
