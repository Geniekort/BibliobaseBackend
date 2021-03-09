module Types::Query
  module DataTypes
    def self.included(child_class)
      child_class.field :data_types,
          [Types::Object::Data::DataType],
          null: false do
        description "Index DataTypes"
        argument :project_id, GraphQL::Types::ID, required: true
      end

      child_class.field :data_type, Types::Object::Data::DataType, null: true do
        description "Find a DataType by ID"
        argument :id, GraphQL::Types::ID, required: true
      end
    end

    def data_types(project_id:)
      Project.find(project_id).data_types
    end

    def data_type(id:)
      Data::DataType.find(id)
    end
  end
end
