module Mutations::CurationSession
  class UpdateCurateRecord < Mutations::BaseMutation
    graphql_name "UpdateCurateRecord"

    argument :input, Types::Input::UpdateCurateRecord, required: true
    argument :id, ID, required: true

    field :curated_record, Types::Object::ImportRecord, null: false
    field :data_object, Types::Object::Data::DataObject, null: true

    def resolve(id:, input:)
      curation_action = Audit::CurationAction.find(id)

      api_object = ApiObject::CurationSession::UpdateCurateRecord.new(curation_action, input.to_h.merge(user: context[:current_user]))

      if api_object.validate
        api_object.save
      end

      return render_resource(:curated_record, api_object)
    end
  end
end
