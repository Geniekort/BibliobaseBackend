module Service::CurationSession::CurateRecord
  # Perform a "Create" curation action. Creating a new DataObject, and corresponding data actions
  class Create < Base
    def perform!
      create_data_object!
      create_curation_action(new_data_object)
    end

    def create_data_object!
      new_data_object.save!
    end

    def new_data_object
      @new_data_object ||= record.data_type.data_objects.new(
        data: params[:data_object_data],
        project: record.project
      )
    end

    def validate
      super && validate_data_object
    end

    def validate_data_object
      unless new_data_object.validate
        errors.merge!(new_data_object)
        return false
      end

      true
    end
  end
end
