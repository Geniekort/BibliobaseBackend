module Mutations::Data::DataType
  class Create < Mutations::BaseMutation

    graphql_name "CreateDataType"

    argument :name, String, required: true
    argument :definition, GraphQL::Types::JSON, required: true
    argument :project_id, ID, required: true

    field :data_type, Types::Object::Data::DataType, null: false

    def resolve(name:, definition:, project_id:)
      data_type = project(project_id).data_types.new(
        name: name, 
        definition: definition
      )

      data_type.save
      render_resource(:data_type, data_type)
    end

    def project(project_id)
      @project ||= Project.find(project_id)
    end
  end
end
