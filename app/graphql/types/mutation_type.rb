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

    field :create_import,
          mutation: Mutations::Import::Create,
          description: "Create a new import"
    field :update_import,
          mutation: Mutations::Import::Update,
          description: "Update an import"
    field :delete_import,
          mutation: Mutations::Import::Delete,
          description: "Delete an import"
    field :preparse_import,
          mutation: Mutations::Import::Preparse,
          description: "Preparse an input to preview what the parsed_data would look like"

    field :file_tester,
          mutation: Mutations::FileTester,
          description: "Test the file"
  end
end
