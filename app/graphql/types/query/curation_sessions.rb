module Types::Query
  module CurationSessions
    def self.included(child_class)
      child_class.field(
        :curation_sessions,
        [Types::Object::CurationSession],
        null: false
      ) do
        description "Index CurationSession"
        argument :project_id, GraphQL::Types::ID, required: true
      end

      child_class.field(:curation_session, Types::Object::CurationSession, null: true) do
        description "Find a curation_session by ID"
        argument :id, GraphQL::Types::ID, required: true
      end
    end

    def curation_sessions(project_id:)
      Project.find(project_id).curation_sessions
    end

    def curation_session(id:)
      CurationSession.includes(import: {import_records: :curation_actions}).find(id)
    end
  end
end
