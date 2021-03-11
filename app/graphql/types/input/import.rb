module Types::Input
  class Import < Types::BaseInputObject
    graphql_name "ImportInput"

    description "Input data for Import mutations"

    argument :name, String, required: false,
      description: "Name of the import"
    argument :raw_data, String, required: false,
      description: "The raw data contained in the imported file"
    argument :meta, GraphQL::Types::JSON, required: false,
      description: "Meta data of the file"
    argument :project_id, ID, required: false
  end
end
