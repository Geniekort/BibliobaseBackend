class Audit::CurationAction < Audit::Action
  def curation_type
    meta["curation_type"]
  end

  def validate_meta
    unless %w[Discard Create].include? meta["curation_type"]
      errors.add(:meta, :invalid_curation_type)
      return false
    end

    true
  end  
end
