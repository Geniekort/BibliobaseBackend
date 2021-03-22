module Mutations::Import
  class Update < Mutations::BaseMutation
    graphql_name "UpdateImport"

    argument :id, ID, required: true
    argument :input, Types::Input::Import, required: true
    argument :parse_data, Boolean, required: false

    field :import, Types::Object::Import, null: false

    def resolve(id:, input:, parse_data: false)
      import = Import.find(id)
      import.service(:updater, { input: input.to_h, parse_data: parse_data }).perform
      render_resource(:import, import)
    end
  end
end
