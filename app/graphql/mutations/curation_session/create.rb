module Mutations::CurationSession
  class Create < Mutations::BaseMutation
    graphql_name "CreateCurationSession"

    argument :input, Types::Input::CurationSession::Create, required: true

    field :curation_session, Types::Object::CurationSession, null: false

    def resolve(input:)
      new_attributes = input.to_h.merge(started_by_id: context[:current_user].id)
      curation_session = CurationSession.new(new_attributes)
      curation_session.save
      render_resource(:curation_session, curation_session)
    end
  end
end
