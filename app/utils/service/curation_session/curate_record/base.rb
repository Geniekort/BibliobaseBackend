module Service::CurationSession::CurateRecord

  class Base < Service::Base
    # Can be used to provide detailed errors to the parent object using this service (e.g. an ApiObject)
    def errors
      {}
    end
  end
end
