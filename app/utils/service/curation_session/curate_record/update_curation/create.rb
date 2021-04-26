module Service::CurationSession::CurateRecord::UpdateCuration
  # Update an existing curation action. Handles the scenarios:
  #  1. Update from a Create curation to a Delete curation, deleting the created data object
  #  2. Update a Create curation with new data object attributes, updating the created data object.
  # TODO: When implementing the auditing framework: HOW TO DEAL WITH ACTIONS ALREADY PERFORMED ON A DATA OBJECT IN 2,3?
  class Create < Base
    def perform!
      if new_curation_type && new_curation_type == "Delete"
        created_data_object.destroy # Delete created data object
        record.destroy
        delete_service.perform
      else
        updated_data_object.save!
      end
    end

    def delete_service
      @delete_service ||= Service::CurationSession::CurateRecord::Delete.new(
        record.curation_session,
        record.import_record,
        params
      )
    end

    def updated_data_object
      return @updated_data_object if @updated_data_object

      @updated_data_object = created_data_object
      @updated_data_object.data = @updated_data_object.data.merge(params[:data_object_data] || {})
      @updated_data_object
    end

    def new_curation_type
      params[:curation_type]
    end

    def created_data_object
      record.created_data_object
    end

    def validate
      if (!new_curation_type || new_curation_type == "Create") && !updated_data_object.validate
        # Validate data_object manually
        errors.merge!(updated_data_object)
        return false
      end

      true
    end
  end
end
