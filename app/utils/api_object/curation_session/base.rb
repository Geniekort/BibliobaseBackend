module ApiObject::CurationSession
  class Base < ApiObject::Base    
    # Validate whether the curation_type in the input is valid
    def validate_curation_type
      unless %w[Create Delete].include? curation_type
        errors.add(:input, :invalid_curation_type)
        return false
      end

      true
    end

    def curation_type
      input[:curation_type]
    end
  end
end
