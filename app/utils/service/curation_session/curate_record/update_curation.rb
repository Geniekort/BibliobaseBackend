module Service::CurationSession::CurateRecord
  # Update an existing curation action. Handles the different scenarios:
  #  1. Update from a Delete curation to a Create curation, creating a new data object
  #  2. Update from a Create curation to a Delete curation, deleting the created data object
  #  3. Update a Create curation with new data object attributes, updating the created data object.
  # TODO: When implementing the auditing framework: HOW TO DEAL WITH ACTIONS ALREADY PERFORMED ON A DATA OBJECT IN 2,3?
  class UpdateCuration < Service::Base
    def perform!
      record.destroy

      if record.curation_type == "Create"
        handle_create_curation_update
      elsif record.curation_type == "Delete"
        handle_delete_curation_update
      end
    end

    def handle_create_curation_update
      created_data_object = record.created_data_object
      if new_curation_type && new_curation_type == "Delete"
        record.created_data_object.destroy # Delete created data object
      else
        created_data_object.data = created_data_object.data.merge(params[:data_object_data] || {})
        created_data_object.save
      end
    end

    def handle_delete_curation_update
      if new_curation_type && new_curation_type == "Create"
        service = Service::CurationSession::CurateRecord::Create.new(record.curation_session, record.import_record,
                                                                     params)
        service.perform
      end
    end

    def new_curation_type
      params[:curation_type]
    end

    def validate
      true
    end
  end
end
