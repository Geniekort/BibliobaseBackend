module Types::Query
  module DataObjects
    def self.included(child_class)
      child_class.field :data_objects,
          [Types::Object::Data::DataObject],
          null: false do
        description "Index DataObjects"
        argument :project_id, GraphQL::Types::ID, required: true
      end

      child_class.field :data_objects_for_data_type,
          [Types::Object::Data::DataObject],
          null: false do
        description "Index DataObjects for a specific DataType"
        argument :data_type_id, GraphQL::Types::ID, required: true
      end

      child_class.field :data_object, Types::Object::Data::DataObject, null: true do
        description "Find a DataObject by ID"
        argument :id, GraphQL::Types::ID, required: true
      end
    end

    def data_objects(project_id:)
      Project.find(project_id).data_objects
    end

    def data_objects_for_data_type(data_type_id:)
      data_type(id: data_type_id).data_objects
    end

    def data_type(id:)
      Data::DataType.find(id)
    end

    def data_object(id:)
      Data::DataObject.find(id)
    end
  end
end
