module ApiObject::CurationSession
  class UpdateCurateRecord < Base

    delegate_missing_to :import_record

    def save
      if curation_service.perform
        true
      else
        false
      end
    end

    def validate
      input[:curation_type] ||= record.curation_type
      return false unless validate_curation_type

      unless curation_service.validate
        errors.merge!(curation_service)
        return false
      end

      true
    end

    private

    def curation_session
      record.curation_session
    end

    def import_record
      record.import_record
    end

    def curation_service
      @curation_service ||= Service::CurationSession::CurateRecord::UpdateCuration.new(record, input)
    end
  end
end
