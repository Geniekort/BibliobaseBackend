module Types::Object
  class Project < Types::BaseObject
    description "A project"

    field :id, ID, null: false
    field :name, String, null: false
    field :data_types, [Types::Object::Data::DataType], null: false

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
