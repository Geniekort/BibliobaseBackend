require "rails_helper"

RSpec.describe Query::Node::Matcher::Exactly do
  let(:context) { build_simple_query_context }
  let(:project) { context.project }
  let(:queried_data_type) { context.queried_data_type }
  let(:queried_attribute) { queried_data_type.data_attributes.first }
  let(:node_key) { "exactly" }

  let(:query_hash) { { queried_attribute.name => "some test value" } }

  let(:data_object) { build(:data_object, data_type: queried_data_type, project: project) }

  let(:subject) { described_class.new(node_key, context, query_hash) }

  describe "#initialize" do
    context "with a simple queried attribute" do
      it "initializes the children nodes (matcher_entries) based off the query_hash" do
        matcher_entry = subject.matcher_entries.first
        expect(matcher_entry).to be_a Query::Node::Matcher::MatcherEntry
        expect(matcher_entry.value).to eq "some test value"
        expect(matcher_entry.node_key).to eq queried_attribute.name
      end
    end
  end

  describe "#validate" do
    context "with valid input" do
      it "does validate" do
        expect(subject.validate).to eq true
      end
    end

    context "with an invalid node_key" do
      let(:node_key) { "exxxxactly" }

      it "does not validate" do
        expect(subject.validate).to eq false
        expect(subject.full_errors_details[:node_key]).to include(error: :invalid)
      end
    end

    context "with invalidated matcher_entries" do
      let(:matcher_entry) { subject.matcher_entries.first }

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
  end
end
