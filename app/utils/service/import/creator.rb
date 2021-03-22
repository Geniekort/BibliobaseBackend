module Service::Import
  class Creator < Base
    def perform
      record.assign_attributes params[:input]
      # record.service(:parser).perform
      byebug
      record.save
    end
  end
end
