require "rails_helper"

RSpec.describe Query::DataRetriever do

  describe ".retrieve_data" do
    context "with a simple query node" do
      let(:query_node) { build_exactly_query_node}
      let(:queried_data_type) { query_node.context.queried_data_type }
      let(:context) { query_node.context }

      before(:each) do
        @data_objects = 2.times.map do
          create(:data_object, data_type: queried_data_type, project: queried_data_type.project)
        end
      end

      it "loads all data objects of the queried data_type" do
        described_class.retrieve_data(query_node)
        expect(context.included_data_objects).to be_a Hash
        expect(context.included_data_objects[queried_data_type.id]).to eq @data_objects
      end
    end
  end
end
