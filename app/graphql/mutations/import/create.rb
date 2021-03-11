module Mutations::Import
  class Create < Mutations::BaseMutation
    graphql_name "CreateImport"

    argument :input, Types::Input::Import, required: true

    field :import, Types::Object::Import, null: false

    def resolve(input:)
      import = Import.new(input.to_kwargs)
      import.save
      render_resource(:import, import)
    end
  end
end
