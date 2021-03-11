module Mutations::Import
  class Update < Mutations::BaseMutation
    graphql_name "UpdateImport"

    argument :id, ID, required: true
    argument :input, Types::Input::Import, required: true

    field :import, Types::Object::Import, null: false

    def resolve(id:, input:)
      import = Import.find(id)
      import.update(input.to_kwargs)
      render_resource(:import, import)
    end
  end
end
