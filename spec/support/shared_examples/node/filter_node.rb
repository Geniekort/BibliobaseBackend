RSpec.shared_examples "initializes like a filter_node" do
  describe "#initialize" do
    it "calls the FilterNodeFactory to construct child nodes" do
      child_node = double
      expect(Query::FilterNodeFactory).to receive(:parse_node)
        .with("exactly", { "testnodestobestubbed" => true }, anything)
        .and_return(child_node)

      created_instance = described_class.new(node_key, context, query_hash)

      expect(created_instance.children).to eq [child_node]
    end
  end
end

RSpec.shared_examples "validates like a filter_node" do |valid_node_key|
  describe "#validate" do
    before do
      subject.node_key = node_key
    end

    context "with valid node key" do
      let(:node_key){ valid_node_key }
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
  end
end
