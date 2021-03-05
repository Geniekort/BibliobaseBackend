module Mutations::Project
  class Update < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false

    field :project, Types::Object::Project, null: false

    def resolve(params)
      project = Project.find(params[:id])
      project.update(params)
      render_resource(:project, project)
    end
  end
end
