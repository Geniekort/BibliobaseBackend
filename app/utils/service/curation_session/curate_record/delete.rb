module Service::CurationSession::CurateRecord
  # Perform a "Delete" curation action.
  class Delete < Base
    def perform!
      create_curation_action
    end
  end
end
