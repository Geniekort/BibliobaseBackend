require "rails_helper"

RSpec.describe Query::FilterNodeFactory do
  let(:context) { build_simple_query_context }

  describe ".parse_node" do
    let(:fake_subquery) { { "test_query_hash" => "unused" } }

    context "with valid input" do
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

    context "with invalid input" do
      context "with an unknown node_key" do
        it "raises a InvalidQueryError" do
          expect{ described_class.parse_node("blabla_fake_node", fake_subquery, context) }.to raise_error Query::InvalidQueryError
        end
      end

      context "with input that does not initialize correctly" do
        it "raises a InvalidQueryError" do
          skip "Implicitely passes, should allow granular syntax error detection in the future"
        end
      end
    end
  end
end
