require "rails_helper"

RSpec.describe Query::Node::Matcher::MatcherEntry do
  let(:queried_attribute_type) { "Text" }
  let(:context) { build_simple_query_context(queried_attribute_type) }
  let(:project) { context.project }
  let(:queried_data_type) { context.queried_data_type }
  let(:node_key) { queried_attribute.name }

  let(:value) { "some_test_value" }
  let(:data_object) { build(:data_object, data_type: queried_data_type, project: project) }

  let(:allowed_data_attribute_types) { %w[Text] }
  let(:allowed_value_types) { "String" }
  let(:subject) { described_class.new(node_key, value, context, allowed_data_attribute_types, allowed_value_types) }
  let(:queried_attribute) { queried_data_type.data_attributes.first }

  describe "validate" do
    context "with a valid node_key" do
      it "does validate" do
        expect(subject.validate).to eq true
      end
    end

    context "with node_key that does not corresponds to any data attribute" do
      let(:node_key) { "random_key" }

      it "does validate" do
        expect(subject.validate).to eq false
        expect(subject.full_errors_details[:node_key]).to include(error: :invalid_attribute_name,
                                                                  matched_data_attribute_name: "random_key")
      end
    end

    context "with an invalid matching data_attribute type" do
      let(:queried_attribute_type) { "Number" }

      it "does not validate" do
        expect(subject.validate).to eq false
        expect(subject.full_errors_details[:node_key]).to include(
          error: :invalid_matching_data_attribute_type,
          matched_data_attribute_name: queried_attribute.name
        )
      end
    end

    context "with an invalid value type" do
      let(:value) { 123 }

      it "does not validate" do
        expect(subject.validate).to eq false
        expect(subject.full_errors_details[:value]).to include(
          error: :invalid_type,
          matched_data_attribute_name: queried_attribute.name
        )
      end
    end
  end

  describe "#retrieve_object_value" do
    context "with a simple key" do
      before do
        data_object.data[queried_attribute.id.to_s] = "The Object Value!"
      end

      it "returns the value of the data_object for the attribute" do
        expect(subject.retrieve_object_value(data_object)).to eq "The Object Value!"
      end
    end
  end
end
