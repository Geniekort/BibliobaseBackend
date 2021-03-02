module Mutations::Project
  class Create < Mutations::BaseMutation
    argument :name, String, required: true

    field :project, Types::ProjectType, null: false

    def resolve(name:)
      project = Project.new(name: name)
      project.save
      render_resource(:project, project)
    end
  end
end
