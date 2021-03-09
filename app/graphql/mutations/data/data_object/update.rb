module Mutations::Data::DataObject
  class Update < Mutations::BaseMutation

    graphql_name "UpdateDataObject"

    argument :id, ID, required: true
    argument :input, Types::Input::Data::DataObject, required: true

    field :data_object, Types::Object::Data::DataObject, null: false

    def resolve(input:, id:)
      data_object = Data::DataObject.find(id)
      data_object.update(input.to_kwargs)
      render_resource(:data_object, data_object)
    end
  end
end
