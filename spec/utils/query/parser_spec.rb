require "rails_helper"

RSpec.describe Query::Parser do
  let(:attribute) { build(:attribute) }
  let(:data_type) { attribute.data_type }

  describe ".parse_query" do
    context "with simple query" do
      let(:query_string) do
        {
          exactly: {
            attribute.name => "test value"
          }
        }.to_json
      end

      it "returns the correctly parsed Node (tree)" do
        result = described_class.parse_query(data_type, query_string)

        expect(result).to be_a Query::Node::Matcher::Exactly

        matcher_entry = result.matcher_entries[0]

        expect(matcher_entry).to be_a Query::Node::Matcher::MatcherEntry
        expect(matcher_entry.node_key).to eq attribute.name
        expect(matcher_entry.value).to eq "test value"
      end
    end

    context "with nested query" do
      let(:query_string) do
        {
          or: [
            {
              exactly: {
                attribute.name => "test value"
              }
            },
            {
              exactly: {
                attribute.name => "other test value"
              }
            }
          ]
        }.to_json
      end

      it "returns the correctly parsed Node (tree)" do
        result = described_class.parse_query(data_type, query_string)

        expect(result).to be_a Query::Node::ControlFlow::Or

        first_root_child = result.children[0]
        second_root_child = result.children[1]

        expect(first_root_child).to be_a Query::Node::Matcher::Exactly
        expect(second_root_child).to be_a Query::Node::Matcher::Exactly

        matcher_entry = second_root_child.matcher_entries[0]

        expect(matcher_entry).to be_a Query::Node::Matcher::MatcherEntry
        expect(matcher_entry.node_key).to eq attribute.name
        expect(matcher_entry.value).to eq "other test value"
      end
    end

    context "with query with multiple root keys" do
      let(:query_string) do
        {
          or: [
            {
              exactly: {
                attribute.name => "test value"
              }
            }
          ],
          exactly: {
            attribute.name => "other test value"
          }
        }.to_json
      end

      it "returns the correctly parsed Node (tree) putting an And node to join the root keys" do
        result = described_class.parse_query(data_type, query_string)

        expect(result).to be_a Query::Node::ControlFlow::And

        first_root_child = result.children[0]
        second_root_child = result.children[1]

        expect(first_root_child).to be_a Query::Node::ControlFlow::Or
        expect(second_root_child).to be_a Query::Node::Matcher::Exactly

        matcher_entry = second_root_child.matcher_entries[0]

        expect(matcher_entry).to be_a Query::Node::Matcher::MatcherEntry
        expect(matcher_entry.node_key).to eq attribute.name
        expect(matcher_entry.value).to eq "other test value"
      end
    end

    context "with query with multiple root keys as an array" do
      let(:query_string) do
        [
          {
            or: [
              {
                exactly: {
                  attribute.name => "test value"
                }
              }
            ]
          },
          {
            exactly: {
              attribute.name => "other test value"
            }
          }
        ].to_json
      end

      it "returns the correctly parsed Node (tree) putting an And node to join the root keys" do
        result = described_class.parse_query(data_type, query_string)

        expect(result).to be_a Query::Node::ControlFlow::And

        first_root_child = result.children[0]
        second_root_child = result.children[1]

        expect(first_root_child).to be_a Query::Node::ControlFlow::Or
        expect(second_root_child).to be_a Query::Node::Matcher::Exactly

        matcher_entry = second_root_child.matcher_entries[0]

        expect(matcher_entry).to be_a Query::Node::Matcher::MatcherEntry
        expect(matcher_entry.node_key).to eq attribute.name
        expect(matcher_entry.value).to eq "other test value"
      end
    end

    context "with an empty query" do
      let(:query_string) { "" }

      it "returns an empty And node" do
        result = described_class.parse_query(data_type, query_string)

        expect(result).to be_a Query::Node::ControlFlow::And

        expect(result.children.length).to eq 0
      end
    end

    context "with an invalid query" do
      context "with invalid keys" do
        let(:query_string) do
          {
            boor: [
              {
                exactly: {
                  attribute.name => "test value"
                }
              }
            ]
          }.to_json
        end

        it "returns the correctly parsed Node (tree) putting an And node to join the root keys" do
          expect { described_class.parse_query(data_type, query_string) }.to raise_error Query::InvalidQueryError
        end
      end

      context "with invalid json" do
        let(:query_string) { "blablabl" }

        it "returns the correctly parsed Node (tree) putting an And node to join the root keys" do
          expect { described_class.parse_query(data_type, query_string) }.to raise_error Query::InvalidQueryError
        end
      end
    end
  end
end
