module Service::Import
  class Updater < Base
    def perform
      record.assign_attributes params[:input]
      record.save
    end
  end
end
