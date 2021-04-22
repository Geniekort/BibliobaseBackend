require "rails_helper"

require_relative "../../../support/graphql_helpers"

include GraphQL::TestHelpers

RSpec.describe Mutations::CurationSession::CurateRecord, type: :request do
  describe "#resolve" do
    let(:user) { create(:user) }
    let(:import) { create(:import, project: project) }
    let(:import_record) { create(:import_record, import: import) }
    let(:data_type) { create(:data_type, project: project) }
    let(:project) { create(:project) }
    let(:curation_session) { create(:curation_session, project: project, import: import, data_type: data_type) }
    let(:mutation_string) do
      <<~GQL
        mutation curateRecord($input: CurateRecordInput!){
          curateRecord(input: $input) {
            curatedRecord {
              id
            }
          }
        }
      GQL
    end

    context "with delete input" do
      before do
        mutation mutation_string,
                 variables: {
                   input: {
                     curation_session_id: curation_session.id,
                     import_record_id: import_record.id,
                     curation_type: "Delete"
                   }
                 },
                 context: { current_user: user }
      end

      it "creates a CurationAction" do
        expect(curation_session.curation_actions.length).to eq 1
      end

      it "creates a CurationAction for the specific import_record" do
        expect(curation_session.curation_actions.first.import_record).to eq import_record
      end

      it "creates a CurationAction for the specific curation_type" do
        expect(curation_session.curation_actions.first.curation_type).to eq "Delete"
      end

      it "does not create a DataObject" do
        expect(data_type.data_objects.length).to eq 0
      end

      it "returns no errors" do
        expect(gql_response.errors).to eq nil
      end
    end

    context "with create input" do
      let(:text_attribute) { create(:attribute, name: "title", data_type: data_type) }

      before do
        mutation mutation_string,
                 variables: {
                   input: {
                     curation_session_id: curation_session.id,
                     import_record_id: import_record.id,
                     curation_type: "Create",
                     data_object_data: {
                       text_attribute.id.to_s => "Some test value"
                     }
                   }
                 },
                 context: { current_user: user }
      end

      it "creates a CurationAction" do
        expect(curation_session.curation_actions.length).to eq 1
      end

      it "creates a CurationAction for the specific import_record" do
        expect(curation_session.curation_actions.first.import_record).to eq import_record
      end

      it "creates a CurationAction for the specific curation_type" do
        expect(curation_session.curation_actions.first.curation_type).to eq "Create"
      end

      it "creates a DataObject" do
        expect(data_type.data_objects.length).to eq 1
      end

      it "creates a DataObject with the correct data" do
        expect(data_type.data_objects.first.data).to eq(
          {
            text_attribute.id.to_s => "Some test value"
          }
        )
      end

      it "returns no errors" do
        expect(gql_response.errors).to eq nil
      end

      describe "validation errors" do
        context "with required attributes but no data" do
          let(:text_attribute) { create(:attribute, :required, name: "title", data_type: curation_session.data_type) }
          before do
            mutation mutation_string,
            variables: {
              input: {
                curation_session_id: curation_session.id,
                import_record_id: import_record.id,
                curation_type: "Create",
                data_object_data: {
                  text_attribute.id.to_s => ""
                }
              }
            },
            context: { current_user: user }
          end

          it "returns no errors" do
            expect(gql_response.errors).not_to eq nil
          end

        end
        
      end
    end
  end
end
