module Mutations::CurationSession
  class Update < Mutations::BaseMutation
    graphql_name "UpdateCurationSession"

    argument :id, ID, required: true
    argument :input, Types::Input::CurationSession::Update, required: true

    field :curation_session, Types::Object::CurationSession, null: false

    def resolve(id:, input:)
      new_attributes = input.to_h
      curation_session = CurationSession.find(id)
      curation_session.update(new_attributes)
      render_resource(:curation_session, curation_session)
    end
  end
end
