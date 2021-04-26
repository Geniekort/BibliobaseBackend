module ApiObject
  class Base
    include ActiveModel::Model

    attr_reader :input, :record

    def initialize(record = nil, input = {})
      @record = record
      @input = input
    end

    def perform
      raise NotImplementedError
    end
  end
end
