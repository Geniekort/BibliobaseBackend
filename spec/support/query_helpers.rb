def build_simple_query_context(attribute_type="Text")
  attribute = create(:attribute, attribute_type: attribute_type)
  data_type = attribute.data_type
  data_type.project = attribute.project
  project = attribute.project

  Query::Context.new(project, data_type)
end

def build_exactly_query_node
  context = build_simple_query_context
  attribute = context.queried_data_type.data_attributes.first
  Query::Node::Matcher::Exactly.new("exactly", context, {attribute.name => "test_value"})
end
