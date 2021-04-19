class Audit::CurationAction < ApplicationRecord
  include Audit::ActionDetailer

  validates :curation_type, presence: true, inclusion: { in: %w[Create Delete] }
  belongs_to :curation_session

  def curated_record
    curation_session.curatable_records.find(import_record_id)
  end
end
