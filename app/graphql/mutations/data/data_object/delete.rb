module Mutations::Data::DataObject
  class Delete < Mutations::BaseMutation

    graphql_name "DeleteDataObject"

    argument :id, ID, required: true

    field :data_type, Types::Object::Data::DataObject, null: false

    def resolve(id:)
      data_type = Data::DataObject.find(id)
      data_type.destroy!
      render_resource(:data_type, data_type)
    end
  end
end
