require "rails_helper"

RSpec.describe Query::DataFilter do
  describe ".filter_data" do
    context "with a simple query node" do
      let(:query_node) { build_exactly_query_node }
      let(:queried_data_type) { query_node.context.queried_data_type }
      let(:queried_attribute) { queried_data_type.data_attributes.first }
      let(:matcher_entry) { query_node.matcher_entries.first }

      before(:each) do
        @matching_data_object = create(:data_object,
                                       data_type: queried_data_type, project: queried_data_type.project,
                                       data: {
                                         queried_attribute.id.to_s => matcher_entry.value
                                       })

        @unmatching_data_object = create(:data_object,
                                         data_type: queried_data_type, project: queried_data_type.project,
                                         data: {
                                           queried_attribute.id.to_s => "NOT MATCHING VALUE"
                                         })

        query_node.context.included_data_objects = {
          queried_data_type.id => [@matching_data_object, @unmatching_data_object]
        }
      end

      it "loads all data objects of the queried data_type" do
        result = described_class.filter_data(query_node)
        expect(result).to include @matching_data_object
        expect(result).not_to include @unmatching_data_object
      end
    end
  end
end
