# TODO: JUST HERE FOR DEBUGGING PURPOSES

module Mutations
  class FileTester < Mutations::BaseMutation
    argument :file, Types::Scalar::FileType, required: true

    field :id, ID, null: false

    def resolve(file:)
      {"Test" => "Go"}
    end
  end
end
