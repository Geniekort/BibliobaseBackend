module Types::Input::ImportField
  class Meta < Types::BaseInputObject
    graphql_name "ImportMetaInput"

    description "Input data for Import Meta field"
    
    argument :format, String, required: false,
      description: "The format of the file"
    argument :headers, Boolean, required: false,
      description: "Whether the (csv) file contains headers"
    argument :column_separator, String, required: false,
      description: "What is the column separator of the (csv) file"    
  end
end
