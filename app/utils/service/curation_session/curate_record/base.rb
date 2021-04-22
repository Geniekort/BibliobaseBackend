module Service::CurationSession::CurateRecord

  class Base < Service::Base
    attr_reader :import_record

    def initialize(curation_session, import_record, params = {})
      @import_record = import_record
      super(curation_session, params)
    end

    def create_curation_action
      Audit::CurationAction.create_with_action(
        {
          curation_type: self.class.name.demodulize,
          import_record_id: import_record.id,
          curation_session: record,
        },
        {
          created_by: params[:user],
          project_id: record.project.id
        }
      )
    end
  end
end
