module Mutations::Import
  class Preparse < Mutations::BaseMutation
    graphql_name "PreparseImport"

    argument :id, ID, required: true
    argument :input, Types::Input::Import, required: true

    field :import, Types::Object::Import, null: false

    def resolve(id:, input:)
      import = Import.find(id)
      import.service(:updater, { input: input.to_h, parse_data: true }).perform(persist: false)
      render_resource(:import, import)
    end
  end
end
