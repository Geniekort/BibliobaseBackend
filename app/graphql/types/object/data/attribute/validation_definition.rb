module Types::Object::Data::Attribute
  class ValidationDefinition < Types::BaseObject
    description "A validation definition for a specific attribute"

    field :referred_data_type, GraphQL::Types::JSON, null: true
  end
end
