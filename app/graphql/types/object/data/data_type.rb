module Types::Object::Data
  class DataType < Types::BaseObject
    description "A data type"

    field :id, ID, null: false
    field :name, String, null: false
    field :definition, GraphQL::Types::JSON, null: false
    field :data_attributes, [Types::Object::Data::DataAttribute], null: false
    field :data_objects, [Types::Object::Data::DataObject], null: false

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
