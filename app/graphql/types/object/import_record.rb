module Types::Object
  class ImportRecord < Types::BaseObject
    description "A import"

    field :id, ID, null: false
    field :data, GraphQL::Types::JSON, null: true
    field :status, String, null: true do
      argument :curation_session_id, GraphQL::Types::ID, required: true
    end

    field :curation_actions, [Types::Object::Audit::CurationAction], null: true do
      argument :curation_session_id, GraphQL::Types::ID, required: true
    end

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def status(curation_session_id:)
      object.status_for_curation_session(curation_session_id)
    end

    def curation_actions(curation_session_id:)
      object.curation_actions_for_curation_session(curation_session_id)
    end
  end
end
