class BibliobaseBackendSchema < GraphQL::Schema
  # It's important that this line goes before setting the query and mutation type on your
  # schema in graphql versions < 1.10.0
  use GraphqlDevise::SchemaPlugin.new(
    query: Types::QueryType,
    mutation: Types::MutationType,
    resource_loaders: [
      GraphqlDevise::ResourceLoader.new("User", only: %i[login logout sign_up confirm_account])
    ],
    authenticate_default: false
  )

  mutation(Types::MutationType)
  query(Types::QueryType)

  # # Union and Interface Resolution
  # def self.resolve_type(abstract_type, obj, ctx)
  #   # TODO: Implement this function
  #   # to return the correct object type for `obj`
  #   raise(GraphQL::RequiredImplementationMissingError)
  # end

  # # Relay-style Object Identification:

  # # Return a string UUID for `object`
  # def self.id_from_object(object, type_definition, query_ctx)
  #   # Here's a simple implementation which:
  #   # - joins the type name & object.id
  #   # - encodes it with base64:
  #   # GraphQL::Schema::UniqueWithinType.encode(type_definition.name, object.id)
  # end

  # # Given a string UUID, find the object
  # def self.object_from_id(id, query_ctx)
  #   # For example, to decode the UUIDs generated above:
  #   # type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
  #   #
  #   # Then, based on `type_name` and `id`
  #   # find an object in your application
  #   # ...
  # end
end
