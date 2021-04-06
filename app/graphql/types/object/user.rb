module Types::Object
  class User < Types::BaseObject
    description "A user"

    field :id, ID, null: false
    field :email, String, null: false

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
