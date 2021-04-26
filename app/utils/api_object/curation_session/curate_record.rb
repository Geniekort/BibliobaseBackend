module ApiObject::CurationSession
  class CurateRecord < Base
    delegate_missing_to :import_record

    def initialize(input = {})
      super(nil, input)
    end

    def save
      if curation_service.perform
        true
      else
        false
      end
    end

    def validate
      return false unless validate_curation_type
      return false unless validate_import_record

      unless curation_service.validate
        errors.merge!(curation_service)
        return false
      end

      true
    end

    private

    def import_record
      curation_session.curatable_records.find_by(id: input[:import_record_id])
    end

    def curation_session
      @curation_session ||= CurationSession.find_by(id: input[:curation_session_id])
    end

    def curation_service
      @curation_service ||= curation_service_class.new(curation_session, import_record, input)
    end

    def curation_service_class
      "Service::CurationSession::CurateRecord::#{curation_type}".safe_constantize
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
