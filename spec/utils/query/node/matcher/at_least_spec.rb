require "rails_helper"

RSpec.describe Query::Node::Matcher::AtLeast do
  let(:context) { build_simple_query_context("Number") }
  let(:project) { context.project }
  let(:queried_data_type) { context.queried_data_type }
  let(:queried_attribute) { queried_data_type.data_attributes.first }
  let(:node_key) { "atLeast" }

  let(:query_hash) { { queried_attribute.name => 123 } }
  let(:subject) { described_class.new(node_key, context, query_hash) }
  let(:matcher_entry) { subject.matcher_entries.first }

  describe "#initialize" do
    context "with a simple queried attribute" do
      it "initializes the children nodes (matcher_entries) based off the query_hash" do
        matcher_entry = subject.matcher_entries.first
        expect(matcher_entry).to be_a Query::Node::Matcher::MatcherEntry
        expect(matcher_entry.value).to eq 123
        expect(matcher_entry.node_key).to eq queried_attribute.name
      end

      it "raises an error when missing matcher_entries in the subquery" do
        expect { described_class.new(node_key, context, {}) }.to raise_error Query::InvalidQueryError
      end
    end
  end

  include_examples "validates like a filter_node", "atLeast"

  include_examples "validates like a matcher_node", %w[Number]

  describe "#filter_object" do
    let(:data_object) { build(:data_object, data_type: queried_data_type, project: project) }

    context "with exactly equal value" do
      before do
        allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return(123)
      end

      it "returns false" do
        expect(subject.filter_object(data_object)).to eq false
      end
    end

    context "with exactly smaller value" do
      before do
        allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return(122)
      end

      it "returns false" do
        expect(subject.filter_object(data_object)).to eq false
      end
    end

    context "with larger value" do
      before do
        allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return(124)
      end

      it "returns true" do
        expect(subject.filter_object(data_object)).to eq true
      end
    end

    context "with multiple matcher entries provided" do
      let(:queried_attribute_2) { create(:attribute, data_type: queried_data_type) }
      let(:matcher_entry_2) { subject.matcher_entries[1] }

      let(:query_hash) do
        { queried_attribute.name => 123, queried_attribute_2.name => 456 }
      end

      context "with only some matching values" do
        before do
          allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return(124)
          allow(matcher_entry_2).to receive(:retrieve_object_value).with(data_object).and_return(1)
        end

        it "returns false" do
          expect(subject.filter_object(data_object)).to eq false
        end
      end

      context "with all matching values" do
        before do
          allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return(125)
          allow(matcher_entry_2).to receive(:retrieve_object_value).with(data_object).and_return(500)
        end

        it "returns true" do
          expect(subject.filter_object(data_object)).to eq true
        end
      end
    end
  end
end
