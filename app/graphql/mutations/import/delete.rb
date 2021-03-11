module Mutations::Import
  class Delete < Mutations::BaseMutation
    graphql_name "DeleteImport"

    argument :id, ID, required: true

    field :import, Types::Object::Import, null: false

    def resolve(id:)
      import = Import.find(id)
      import.destroy!
      render_resource(:import, import)
    end
  end
end
