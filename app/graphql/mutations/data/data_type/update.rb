module Mutations::Data::DataType
  class Update < Mutations::BaseMutation

    graphql_name "UpdateDataType"

    argument :id, ID, required: true
    argument :name, String, required: false
    argument :definition, GraphQL::Types::JSON, required: false

    field :data_type, Types::Object::Data::DataType, null: false

    def resolve(params)
      data_type = Data::DataType.find(params[:id])
      data_type.update(params)
      render_resource(:data_type, data_type)
    end
  end
end
