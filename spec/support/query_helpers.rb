def build_simple_query_context()
  attribute = create(:attribute)
  data_type = attribute.data_type
  data_type.project = attribute.project
  project = attribute.project

  Query::Context.new(project, data_type)
end
