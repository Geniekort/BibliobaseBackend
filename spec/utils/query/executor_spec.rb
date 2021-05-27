require "rails_helper"

RSpec.describe Query::Executor do
  describe "#execute" do
    context "with a simple query node" do
      let(:input_string) { "The query string (stubbed)" }
      let(:data_type) { build(:data_type) }
      
      let(:subject) { described_class.new(data_type, input_string)}

      it "executes the query execution steps" do
        node_stub = double
        result_stub = double
        expect(Query::Parser).to receive(:parse_query).with(data_type, input_string).and_return(node_stub)
        expect(Query::DataRetriever).to receive(:retrieve_data).with(node_stub)
        expect(Query::DataFilter).to receive(:filter_data).with(node_stub).and_return(result_stub)
        expect(subject.execute).to eq result_stub
      end
    end
  end
end
