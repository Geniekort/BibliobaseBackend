module Service::CurationSession::CurateRecord
  # Perform a "Delete" curation action. Creating a new DataObject, and corresponding
  class Delete < Base
    def perform!
      create_curation_action
    end
  end
end
