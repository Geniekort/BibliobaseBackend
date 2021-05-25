require "rails_helper"

RSpec.describe Query::FilterNodeFactory do
  let(:context) { build_simple_query_context }

  describe ".parse_node" do
    context "with valid input" do
      let(:fake_subquery) { { "test_query_hash" => "unused" } }
      {
        "and" => Query::Node::ControlFlow::And,
        "or" => Query::Node::ControlFlow::Or,
        "not" => Query::Node::ControlFlow::Not,
        "exactly" => Query::Node::Matcher::Exactly
      }.each do |node_key, expected_node_class|
        context "with an '#{node_key}' node_key" do
          it "generates a #{expected_node_class} node with the provided context and query hash" do
            expect(expected_node_class).to receive(:new).with(
              node_key, fake_subquery, context
            ).and_return(double)

            described_class.parse_node(node_key, fake_subquery, context)
          end
        end
      end
    end
  end
end
