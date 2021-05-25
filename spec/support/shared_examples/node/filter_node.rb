RSpec.shared_examples "initializes like a filter_node" do
  describe "#initialize" do
    it "calls the FilterNodeFactory" do
      child_node = double
      expect(Query::FilterNodeFactory).to receive(:parse_node)
        .with("exactly", { "testnodestobestubbed" => true }, anything)
        .and_return(child_node)

      created_instance = described_class.new(node_key, context, query_hash)

      expect(created_instance.children).to eq [child_node]
    end
  end
end
