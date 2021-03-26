module Service::Import
  class Creator < Base
    def perform
      record.assign_attributes params[:input]
      record.meta ||= {}
      record.meta[:format] = "csv"
      # record.service(:parser).perform
      record.save
    end
  end
end
