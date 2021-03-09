module Mutations::Data::DataObject
  class Create < Mutations::BaseMutation

    graphql_name "CreateDataObject"

    argument :input, Types::Input::Data::DataObject, required: true

    field :data_object, Types::Object::Data::DataObject, null: false

    def resolve(input:)
      data_object = Data::DataObject.new(
        input.to_kwargs
      )

      data_object.save
      render_resource(:data_object, data_object)
    end
  end
end
