module Types::Query
  module Imports
    def self.included(child_class)
      child_class.field(
        :imports,
        [Types::Object::Import],
        null: false,
      ) do
        description "Index Imports"
        argument :project_id, GraphQL::Types::ID, required: true
        
      end

      child_class.field(:import, Types::Object::Import, null: true) do
        description "Find a import by ID"
        argument :id, GraphQL::Types::ID, required: true
      end
    end

    def imports(project_id:)
      imports = Project.find(project_id).imports
      imports
    end

    def import(id:)
      Import.find(id)
    end
  end
end
