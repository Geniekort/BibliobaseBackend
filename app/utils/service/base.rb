module Service
  class Base
    attr_accessor :record, :params

    def initialize(record, params = {})
      @record = record
      @params = params
    end
  end
end
