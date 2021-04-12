class Audit::CurationAction < Audit::ResourceAction
  def curation_type
    meta["curation_type"]
  end

  def validate_meta
    unless %w[Discard Create].include? meta["curation_type"]
      errors.add(:meta, :invalid_curation_type)
      return false
    end

    return false if curation_type == "Create" && !validate_resource

    true
  end

  # Validate whether the resource is actually present
  def validate_resource
    unless resource_type.present? && resource_type.safe_constantize
      errors.add(:resource, :invalid_type)
      return false
    end

    unless resource.present?
      errors.add(:resource, :blank)
      return false
    end

    true
  end
end
