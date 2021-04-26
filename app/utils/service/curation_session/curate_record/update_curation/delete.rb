module Service::CurationSession::CurateRecord::UpdateCuration
  # Update an existing curation action. Handles the scenarios:
  #  1. Update from a Delete curation to a Create curation, creating a new data object
  # TODO: When implementing the auditing framework: HOW TO DEAL WITH ACTIONS ALREADY PERFORMED ON A DATA OBJECT IN 2,3?
  class Delete < Base
    def perform!
      record.destroy

      if new_curation_type && new_curation_type == "Create"
        create_service.perform
      end
    end

    def create_service
      @create_service ||= Service::CurationSession::CurateRecord::Create.new(
        record.curation_session,
        record.import_record,
        params
      )
    end

    def new_curation_type
      params[:curation_type]
    end

    def validate
      if new_curation_type == "Create" && !create_service.validate
        # Validate using new service
        errors.merge!(create_service.errors)
        return false
      end

      true
    end
  end
end
