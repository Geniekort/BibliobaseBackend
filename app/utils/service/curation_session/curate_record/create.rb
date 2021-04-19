module Service::CurationSession::CurateRecord
  # Perform a "Create" curation action. Creating a new DataObject, and corresponding 
  class Create < Base
    def perform!
      create_data_object!
      create_curation_action
    end

    def create_data_object!
      record.data_type.data_objects.create!(
        data: params[:data_object_attributes],
        project: record.project
      )
    end
  end
end
