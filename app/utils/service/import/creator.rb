module Service::Import
  class Creator < Base
    def perform
      record.assign_attributes params[:input]
      record.service(:parser).perform
      record.save
    end
  end
end
