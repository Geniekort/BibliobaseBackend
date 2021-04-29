module Types::Input::CurationSession
  class Update < Types::BaseInputObject
    graphql_name "UpdateCurationSessionInput"

    description "Input data for CurationSession"

    argument :mapping, GraphQL::Types::JSON, required: false
  end
end
