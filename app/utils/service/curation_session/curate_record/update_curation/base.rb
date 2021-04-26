module Service::CurationSession::CurateRecord::UpdateCuration
  # Update an existing curation action. Handles the scenarios:
  #  1. Update from a Create curation to a Delete curation, deleting the created data object
  #  2. Update a Create curation with new data object attributes, updating the created data object.
  # TODO: When implementing the auditing framework: HOW TO DEAL WITH ACTIONS ALREADY PERFORMED ON A DATA OBJECT IN 2,3?
  class Base < Service::Base
    def new_curation_type
      params[:curation_type]
    end
  end
end
