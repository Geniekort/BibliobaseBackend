module Mutations::Project
  class Delete < Mutations::BaseMutation
    argument :id, ID, required: true

    field :project, Types::Object::Project, null: false

    def resolve(id:)
      project = Project.find(params[:id])
      project.destroy!
      render_resource(:project, project)
    end
  end
end
