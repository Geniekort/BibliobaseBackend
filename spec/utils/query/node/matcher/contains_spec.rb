require "rails_helper"

RSpec.describe Query::Node::Matcher::Contains do
  let(:context) { build_simple_query_context }
  let(:project) { context.project }
  let(:queried_data_type) { context.queried_data_type }
  let(:queried_attribute) { queried_data_type.data_attributes.first }
  let(:node_key) { "contains" }

  let(:query_hash) { { queried_attribute.name => test_value } }
  let(:test_value) { "some test value" }
  let(:subject) { described_class.new(node_key, context, query_hash) }
  let(:matcher_entry) { subject.matcher_entries.first }

  describe "#initialize" do
    context "with a simple queried attribute" do
      it "initializes the children nodes (matcher_entries) based off the query_hash" do
        matcher_entry = subject.matcher_entries.first
        expect(matcher_entry).to be_a Query::Node::Matcher::MatcherEntry
        expect(matcher_entry.value).to eq test_value
        expect(matcher_entry.node_key).to eq queried_attribute.name
      end

      it "raises an error when missing matcher_entries in the subquery" do
        expect{described_class.new(node_key, context, {})}.to raise_error Query::InvalidQueryError
      end
    end
  end

  include_examples "validates like a filter_node", "contains"

  include_examples "validates like a matcher_node", %w[Text]

  describe "#filter_object" do
    let(:data_object) { build(:data_object, data_type: queried_data_type, project: project) }

    context "with exactly equal value to test_value" do
      before do
        allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return(test_value)
      end

      it "returns true" do
        expect(subject.filter_object(data_object)).to eq true
      end
    end

    context "with non overlapping value with test value" do
      before do
        allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return("some WRONG test value")
      end

      it "returns false" do
        expect(subject.filter_object(data_object)).to eq false
      end
    end

    context "with superstring of test value" do
      before do
        allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return("some surrounding #{test_value} the testvalue")
      end

      it "returns true" do
        expect(subject.filter_object(data_object)).to eq true
      end
    end

    context "with multiple matcher entries provided" do
      let(:queried_attribute_2) { create(:attribute, data_type: queried_data_type) }
      let(:matcher_entry_2) { subject.matcher_entries[1] }

      let(:query_hash) do
        { queried_attribute.name => test_value, queried_attribute_2.name => "other test value" }
      end

      context "with only some matching values" do
        before do
          allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return(test_value)
          allow(matcher_entry_2).to receive(:retrieve_object_value).with(data_object).and_return("floep WRONG value")
        end

        it "returns false" do
          expect(subject.filter_object(data_object)).to eq false
        end
      end

      context "with all matching values" do
        before do
          allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return(test_value)
          allow(matcher_entry_2).to receive(:retrieve_object_value).with(data_object).and_return("other test value")
        end

        it "returns true" do
          expect(subject.filter_object(data_object)).to eq true
        end
      end
    end
  end
end
