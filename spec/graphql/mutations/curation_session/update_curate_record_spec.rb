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
        mutation updateCurateRecord($id: ID!, $input: UpdateCurateRecordInput!){
          updateCurateRecord(id: $id, input: $input) {
            curatedRecord {
              id
            }
          }
        }
      GQL
    end

    let(:variables) do
      {
        id: curation_action.id,
        input: input
      }
    end

    before do
      mutation mutation_string,
               variables: variables,
               context: { current_user: user }
    end

    context "with an existing Create curation" do
      let(:text_attribute) { create(:attribute, name: "title", data_type: data_type) }

      let(:curation_action) do
        create(:curation_action, :with_action, project: project, curation_session: curation_session,
                                               import_record: import_record, created_data_object: data_object)
      end

      let(:data_object) do
        create(:data_object, data_type: data_type, data: { text_attribute.id.to_s => "Initial value" })
      end

      let(:input) { {} }

      context "with a Create curation as new curation" do
        context "with new data_object_data values" do
          let(:input) { { data_object_data: { text_attribute.id.to_s => "Updated value" } } }

          it "updates the data object a CurationAction" do
            expect(data_object.reload.data[text_attribute.id.to_s]).to eq "Updated value"
          end

          it "returns no errors" do
            expect(gql_response.errors).to eq nil
          end
        end
      end

      context "with Delete curation as new curation" do
        let(:input) { { curation_type: "Delete" } }

        it "deletes the existing data object" do
          expect { data_object.reload }.to raise_error ActiveRecord::RecordNotFound
        end

        it "returns no errors" do
          expect(gql_response.errors).to eq nil
        end
      end
    end

    context "with an existing Delete curation" do
      let(:curation_action) do
        create(:curation_action, :with_action, project: project, curation_session: curation_session,
                                               import_record: import_record, curation_type: "Delete")
      end

      context "with a Create curation as new curation" do
        context "with new data_object_data values" do
          let(:text_attribute) { create(:attribute, name: "title", data_type: data_type) }

          let(:input) do
            {
              data_object_data: { text_attribute.id.to_s => "Newly value" },
              curation_type: "Create"
            }
          end

          it "creates a DataObject" do
            expect(data_type.data_objects.length).to eq 1
          end

          it "creates a DataObject with the correct data" do
            expect(data_type.data_objects.first.data).to eq(
              {
                text_attribute.id.to_s => "Newly value"
              }
            )
          end

          it "returns no errors" do
            expect(gql_response.errors).to eq nil
          end
        end
      end
    end
  end
end
