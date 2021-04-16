module ApiObject
  class Base
    include ActiveModel::Model

    attr_reader :input

    def initialize(input = {})
      @input = input
    end

    def perform
      raise NotImplementedError
    end
  end
end
