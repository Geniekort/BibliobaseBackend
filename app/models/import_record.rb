class ImportRecord < ApplicationRecord
  belongs_to :import
  has_many :curation_actions,
           class_name: "Audit::CurationAction"

  def curation_actions_for_curation_session(curation_session_id)
    curation_actions.select { |x| x.curation_session_id == curation_session_id.to_i }
  end

  def status_for_curation_session(curation_session_id)
    curation_actions_for_curation_session(curation_session_id).last&.curation_type || ""
  end

  class << self
    def insert_all(records)
      normalized = normalize(records)
      super(normalized)
    end

    def normalize(records)
      records.each do |rec|
        add_timestamp(rec)
      end
    end

    def add_timestamp(record)
      time = Time.now.utc

      record["created_at"] = time
      record["updated_at"] = time
    end
  end
end
