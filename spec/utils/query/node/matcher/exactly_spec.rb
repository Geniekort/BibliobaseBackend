require "rails_helper"

RSpec.describe Query::Node::Matcher::Exactly do
  let(:context) { build_simple_query_context }
  let(:project) { context.project }
  let(:queried_data_type) { context.queried_data_type }
  let(:queried_attribute) { queried_data_type.data_attributes.first }
  let(:node_key) { "exactly" }

  let(:query_hash) { { queried_attribute.name => "some test value" } }
  let(:subject) { described_class.new(node_key, context, query_hash) }
  let(:matcher_entry) { subject.matcher_entries.first }

  describe "#initialize" do
    context "with a simple queried attribute" do
      it "initializes the children nodes (matcher_entries) based off the query_hash" do
        matcher_entry = subject.matcher_entries.first
        expect(matcher_entry).to be_a Query::Node::Matcher::MatcherEntry
        expect(matcher_entry.value).to eq "some test value"
        expect(matcher_entry.node_key).to eq queried_attribute.name
      end

      it "raises an error when missing matcher_entries in the subquery" do
        expect{described_class.new(node_key, context, {})}.to raise_error Query::InvalidQueryError
      end
    end
  end

  include_examples "validates like a filter_node", "exactly"

  describe "#validate" do
    context "with valid input" do
      it "does validate" do
        expect(subject.validate).to eq true
      end
    end

    context "with invalidated matcher_entries" do
      before do
        matcher_entry.errors.add(:node_key, :invalid_attribute_name)
        allow(matcher_entry).to receive(:validate).and_return false
      end

      it "merges the error details" do
        expect(subject.validate).to eq false
        expect(subject.full_errors_details[:matcher_entries]).to include(
          {
            node_key: [{ error: :invalid_attribute_name }]
          }
        )
      end
    end
  end

  describe "#filter_object" do
    let(:data_object) { build(:data_object, data_type: queried_data_type, project: project) }

    context "with exactly equal value" do
      before do
        allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return("some test value")
      end

      it "returns true" do
        expect(subject.filter_object(data_object)).to eq true
      end
    end

    context "with not exactly equal value" do
      before do
        allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return("some WRONG test value")
      end

      it "returns false" do
        expect(subject.filter_object(data_object)).to eq false
      end
    end

    context "with multiple matcher entries provided" do
      let(:queried_attribute_2) { create(:attribute, data_type: queried_data_type) }
      let(:matcher_entry_2) { subject.matcher_entries[1] }

      let(:query_hash) do
        { queried_attribute.name => "some test value", queried_attribute_2.name => "other test value" }
      end

      context "with only some matching values" do
        before do
          allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return("some test value")
          allow(matcher_entry_2).to receive(:retrieve_object_value).with(data_object).and_return("floep WRONG value")
        end

        it "returns true" do
          expect(subject.filter_object(data_object)).to eq false
        end
      end

      context "with all matching values" do
        before do
          allow(matcher_entry).to receive(:retrieve_object_value).with(data_object).and_return("some test value")
          allow(matcher_entry_2).to receive(:retrieve_object_value).with(data_object).and_return("other test value")
        end

        it "returns true" do
          expect(subject.filter_object(data_object)).to eq true
        end
      end
    end
  end
end
