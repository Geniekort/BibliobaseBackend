require "rails_helper"

RSpec.describe Query::Node::ControlFlow::Or do
  let(:context) { build_simple_query_context }
  let(:project) { context.project }
  let(:node_key) { "or" }

  let(:query_hash) { [{ "exactly" => { "testnodestobestubbed" => true } }] }
  let(:subject) { described_class.new(node_key, context, query_hash) }
  let(:matcher_entry) { subject.matcher_entries.first }

  include_examples "initializes like a filter_node"
  include_examples "validates like a filter_node", "or"

  describe "#filter_object" do
    let(:data_object) { double }

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

      it "returns true if any child node does" do
        subject.children = [double(filter_object: true), double(filter_object: true), double(filter_object: false)]
        expect(subject.filter_object(data_object)).to eq true
      end

      it "returns false if each child node does" do
        subject.children = [double(filter_object: false), double(filter_object: false), double(filter_object: false)]
        expect(subject.filter_object(data_object)).to eq false
      end
    end
  end
end
