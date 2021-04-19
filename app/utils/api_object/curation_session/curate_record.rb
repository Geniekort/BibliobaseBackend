module ApiObject::CurationSession
  class CurateRecord < ApiObject::Base

    delegate_missing_to :import_record

    def save
      if curation_service.perform
        true
      else
        errors.merge!(curation_service)
        false
      end
    end

    def validate
      return false unless validate_curation_type
      return false unless validate_import_record
    end

    private

    def curation_session
      @curation_session ||= CurationSession.find_by(id: input[:curation_session_id])
    end

    def import_record
      curation_session.curatable_records.find_by(id: input[:import_record_id])
    end

    def curation_type
      input[:curation_type]
    end

    def curation_service
      @curation_service ||= curation_service_class.new(curation_session, import_record, input)
    end

    def curation_service_class
      "Service::CurationSession::CurateRecord::#{curation_type}".safe_constantize
    end

    # Validate whether the curation_type in the input is valid
    def validate_curation_type
      unless %w[Create Delete].include? curation_type
        errors.add(:input, :invalid_curation_type)
        return false
      end

      true
    end

    # Validate whether the import_record_id corresponds to an existing import record
    def validate_import_record
      unless import_record
        errors.add(:input, :import_record_not_found)
        return false
      end

      true
    end
  end
end
