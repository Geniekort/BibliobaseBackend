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

    field :create_data_type,
          mutation: Mutations::Data::DataType::Create,
          description: "Create a new data_type"
    field :update_data_type,
          mutation: Mutations::Data::DataType::Update,
          description: "Update a data_type"
    field :delete_data_type,
          mutation: Mutations::Data::DataType::Delete,
          description: "Delete a data_type"

    field :create_data_object,
          mutation: Mutations::Data::DataObject::Create,
          description: "Create a new data_object"
    field :update_data_object,
          mutation: Mutations::Data::DataObject::Update,
          description: "Update a data_object"
    field :delete_data_object,
          mutation: Mutations::Data::DataObject::Delete,
          description: "Delete a data_object"
  end
end
