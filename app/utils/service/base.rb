module Service
  class Base
    include ActiveModel::Model

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

    def validate
      true
    end
  end
end
