module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    description "The query root of this schema"

    field :projects,
          [Types::ProjectType],
          null: false,
          description: "Index Projects"

    # First describe the field signature:
    field :project, Types::ProjectType, null: true do
      description "Find a project by ID"
      argument :id, ID, required: true
    end

    def projects
      Project.all
    end

    # Then provide an implementation:
    def project(id:)
      Project.find(id)
    end
  end
end