module Mutations::Data::DataType
  class Delete < Mutations::BaseMutation

    graphql_name "DeleteDataType"

    argument :id, ID, required: true

    field :data_type, Types::Object::Data::DataType, null: false

    def resolve(id:)
      data_type = Data::DataType.find(id)
      data_type.destroy!
      render_resource(:data_type, data_type)
    end
  end
end
