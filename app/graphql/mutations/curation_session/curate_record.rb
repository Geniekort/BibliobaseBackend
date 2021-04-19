module Mutations::CurationSession
  class CurateRecord < Mutations::BaseMutation
    graphql_name "CurateRecord"

    argument :input, Types::Input::CurateRecord, required: true

    field :curated_record, Types::Object::ImportRecord, null: false
    field :data_object, Types::Object::Data::DataObject, null: true

    def resolve(input:)
      api_object = ApiObject::CurationSession::CurateRecord.new(input.to_h.merge(user: context[:current_user]))
      api_object.save
      return render_resource(:curated_record, api_object)
    end
  end
end
