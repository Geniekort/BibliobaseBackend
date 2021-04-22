require "rails_helper"

require_relative "../../../support/graphql_helpers"

include GraphQL::TestHelpers

RSpec.describe Mutations::CurationSession::UpdateCurateRecord, type: :request do
  describe "#resolve" do
    let(:user) { create(:user) }
    let(:import) { create(:import, project: project) }
    let(:import_record) { create(:import_record, import: import) }
    let(:data_type) { create(:data_type, project: project) }
    let(:project) { create(:project) }
    let(:curation_session) { create(:curation_session, project: project, import: import, data_type: data_type) }
    let(:mutation_string) do
      <<~GQL
        mutation updateCurateRecord($id: ID!, $input: CurateRecordInput!){
          updateCurateRecord(id: $id, input: $input) {
            curatedRecord {
              id
            }
          }
        }
      GQL
    end

    context "with an existing Create curation" do
      let(:text_attribute) { create(:attribute, name: "title", data_type: data_type) }

      let(:curation_action) do
        create(:curation_action, :with_action, project: project, curation_session: curation_session)
      end

      let(:create_data_object) do
        create(:data_object, data_type: data_type, data: { text_attribute.id.to_s => "Initial value" })
      end

      let(:variables) do
        {
          id: curation_action.id,
          input: input
        }
      end

      let(:input) { {} }

      before do
        mutation mutation_string,
                 variables: variables,
                 context: { current_user: user }
      end

      context "with a Create curation as new curation" do
        context "with new data_object_data values" do
          let(:input) { { data_object_data: { text_attribute.id.to_s => "Updated value" }}}

          it "updates the data object a CurationAction" do
            expect(data_object.reload.data[text_attribute.id.to_s]).to eq "Update value"
          end
        end
      end
    end
  end
end
