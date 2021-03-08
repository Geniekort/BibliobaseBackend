module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    description "The query root of this schema"

    field :data_types,
          [Types::Object::Data::DataType],
          null: false do
      description "Index DataTypes"
      argument :project_id, ID, required: true
    end

    field :data_type, Types::Object::Data::DataType, null: true do
      description "Find a DataType by ID"
      argument :id, ID, required: true
    end

    field :projects,
          [Types::Object::Project],
          null: false,
          extras: [:lookahead],
          description: "Index Projects"

    field :project, Types::Object::Project, null: true do
      description "Find a project by ID"
      argument :id, ID, required: true
    end

    def projects(lookahead:)
      projects = Project.all
      projects = projects.includes(:data_types) if lookahead.selects?(:data_types)
      projects
    end

    def project(id:)
      Project.find(id)
    end

    def data_types(project_id:)
      project(id: project_id).data_types
    end

    def data_type(id:)
      Data::DataType.find(id)
    end
  end
end
