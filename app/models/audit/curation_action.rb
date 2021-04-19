module Audit
  class CurationAction < ApplicationRecord
    include Audit::ActionDetailer

    validates :curation_type, presence: true, inclusion: { in: %w[Create Delete] }
    belongs_to :curation_session
    # Only allow import records that belong to the import of the current curation_session
    belongs_to :import_record, ->(curation_action) { where(import_id: curation_action.curation_session.import_id) }
  end
end
