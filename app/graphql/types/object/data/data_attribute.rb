module Types::Object::Data
  class DataAttribute < Types::BaseObject
    description "A data attribute"

    field :id, ID, null: false
    field :name, String, null: false
    field :attribute_type, String, null: false
    field :validation_definition, Types::Object::Data::Attribute::ValidationDefinition, null: true

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
