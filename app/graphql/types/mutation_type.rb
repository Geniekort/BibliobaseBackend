module Types
  class MutationType < Types::BaseObject
    field :create_project,
          mutation: Mutations::Project::Create,
          description: "Create a new project for the current organization"
    field :update_project,
          mutation: Mutations::Project::Update,
          description: "Update a project for the current organization"
    field :delete_project,
          mutation: Mutations::Project::Delete,
          description: "Delete a project for the current organization"
  end
end
