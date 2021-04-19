module Service
  class Base
    attr_accessor :record, :params

    def initialize(record, params = {})
      @record = record
      @params = params
    end

    def perform(*args)
      ActiveRecord::Base.transaction do
        return true if perform!(*args)
      end
      false
    end
  end
end
