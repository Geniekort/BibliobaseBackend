require "rails_helper"

RSpec.describe Query::Node::ControlFlow::And do
  let(:context) { build_simple_query_context }
  let(:node_key) { "and" }

  let(:query_hash) { [{ "exactly" => { "testnodestobestubbed" => true } }] }
  let(:subject) { described_class.new(node_key, context, query_hash) }
  let(:matcher_entry) { subject.matcher_entries.first }


  include_examples "initializes like a filter_node"
  include_examples "validates like a filter_node", "and"

  describe "#filter_object" do
    let(:data_object) { double }

    context "with no child nodes" do
      it "returns true " do
        subject.children = []
        expect(subject.filter_object(data_object)).to eq true
      end
    end

    context "with one child node" do
      it "returns true if the child node does" do
        subject.children = [double(filter_object: true)]
        expect(subject.filter_object(data_object)).to eq true
      end

      it "returns false if the child node does" do
        subject.children = [double(filter_object: false)]
        expect(subject.filter_object(data_object)).to eq false
      end
    end

    context "with multiple child nodes" do
      it "returns true if each child node does" do
        subject.children = [double(filter_object: true), double(filter_object: true), double(filter_object: true)]
        expect(subject.filter_object(data_object)).to eq true
      end

      it "returns false if any child node does" do
        subject.children = [double(filter_object: true), double(filter_object: true), double(filter_object: false)]
        expect(subject.filter_object(data_object)).to eq false
      end
    end
  end
end
