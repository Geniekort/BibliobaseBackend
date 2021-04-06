require "rails_helper"

require_relative "../../../support/graphql_helpers"

include GraphQL::TestHelpers

RSpec.describe Mutations::CurationSession::Create, type: :request do
  describe "#resolve" do
    let(:user) { create(:user) }
    let(:import) { create(:import, project: project) }
    let(:project) { create(:project) }
    let(:data_type) { create(:data_type, project: project) }
    let(:mutation_string) do
      <<~GQL
        mutation createCurationSession($input: CurationSessionInput!){
          createCurationSession(input: $input) {
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
                   input: {
                     project_id: project.id,
                     import_id: import.id,
                     data_type_id: data_type.id
                   }
                 },
                 context: { current_user: user}
      end

      it "creates a CurationSession" do
        expect(project.curation_sessions.length).to eq 1
      end

      it "creates a CurationSession with the correct data" do
        expect(gql_response.data.dig("createCurationSession", "curationSession", "startedBy", "id").to_i).to eq user.id
      end

      it "returns no errors" do
        expect(gql_response.errors).to eq nil
      end
    end
  end
end
