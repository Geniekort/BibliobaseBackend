require "rails_helper"

require_relative "../../../support/graphql_helpers"

include GraphQL::TestHelpers

RSpec.describe Mutations::CurationSession::Update, type: :request do
  describe "#resolve" do
    let(:user) { create(:user) }
    let(:import) { create(:import, project: project) }
    let(:project) { create(:project) }
    let(:data_type) { create(:data_type, project: project) }
    let(:curation_session) { create(:curation_session, data_type: data_type, project: project, started_by: user, import: import)}
    let(:mutation_string) do
      <<~GQL
        mutation updateCurationSession($id: ID!, $input: UpdateCurationSessionInput!){
          updateCurationSession(id: $id, input: $input) {
            curationSession {
              id
              startedBy {
                id
              }
            }
          }
        }
      GQL
    end

    context "with complete input" do
      before do
        mutation mutation_string,
                 variables: {
                   id: curation_session.id,
                   input: {
                     mapping: {
                       "import_key" => 12
                     }
                   }
                 },
                 context: { current_user: user}
      end

      it "updates the CurationSession" do
        curation_session.reload
        expect(curation_session.project_id).to eq project.id
        expect(curation_session.import_id).to eq import.id
        expect(curation_session.data_type_id).to eq data_type.id
        expect(curation_session.mapping).to eq({"importKey" => 12})

      end

      it "returns no errors" do
        expect(gql_response.errors).to eq nil
      end

      context "with an invalid mapping" do
        pending "it returns validation errors"
      end
    end
  end
end
