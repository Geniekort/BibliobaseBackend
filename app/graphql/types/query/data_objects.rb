module Types::Query
  module DataObjects
    def self.included(child_class)
      child_class.field :data_objects,
          [Types::Object::Data::DataObject],
          null: false do
        description "Index DataObjects"
        argument :project_id, GraphQL::Types::ID, required: true
      end

      child_class.field :data_type, Types::Object::Data::DataObject, null: true do
        description "Find a DataObject by ID"
        argument :id, GraphQL::Types::ID, required: true
      end
    end

    def data_objects(project_id:)
      Project.find(project_id).data_objects
    end

    def data_type(id:)
      Data::DataObject.find(id)
    end
  end
end
