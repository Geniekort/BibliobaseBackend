module Mutations::CurationSession
  class Delete < Mutations::BaseMutation
    graphql_name "DeleteCurationSession"

    argument :id, ID, required: true

    field :curation_session, Types::Object::CurationSession, null: false

    def resolve(id:)
      curation_session = CurationSession.find(id)
      curation_session.destroy!
      render_resource(:curation_session, curation_session)
    end
  end
end
