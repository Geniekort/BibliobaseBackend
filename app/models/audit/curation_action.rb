class Audit::CurationAction < Audit::Action
  
  def curation_session
    project.curation_sessions.find_by(id: meta["curation_session_id"])
  end

  def curation_type
    meta["curation_type"]
  end

  def validate_meta
    unless %w[Discard Create].include? curation_type
      errors.add(:meta, :invalid_curation_type)
      return false
    end

    true
  end  

  def curated_record

  end
end
