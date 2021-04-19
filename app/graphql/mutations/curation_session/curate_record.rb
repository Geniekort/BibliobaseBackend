module Mutations::CurationSession
  class CurateRecord < Mutations::BaseMutation
    graphql_name "CurateRecord"

    argument :input, Types::Input::CurateRecord, required: true

    field :curated_record, Types::Object::ImportRecord, null: false
    field :data_object, Types::Object::Data::DataObject, null: true

    def resolve(input:)
      api_object = ApiObject::CurationSession::CurateRecord.new(input)
      if api_object.save
        return true
      else
        return false
      end
      # new_attributes = input.to_h.merge(started_by_id: context[:current_user].id)
      # curation_session = CurationSession.new(new_attributes)
      # curation_session.save
      # render_resource(:curation_session, curation_session)
    end
  end
end
