module Types::Query
  module Projects
    def self.included(child_class)
      child_class.field(
        :projects,
        [Types::Object::Project],
        null: false,
        extras: [:lookahead],
        description: "Index Projects"
      )

      child_class.field(:project, Types::Object::Project, null: true) do
        description "Find a project by ID"
        argument :id, GraphQL::Types::ID, required: true
      end
    end

    def projects(lookahead:)
      projects = Project.all
      projects = projects.includes(:data_types) if lookahead.selects?(:data_types)
      projects
    end

    def project(id:)
      Project.find(id)
    end
  end
end
