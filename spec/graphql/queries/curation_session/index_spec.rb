require "rails_helper"

require_relative "../../../support/graphql_helpers"

include GraphQL::TestHelpers

RSpec.describe "CurationSession Index" do
  describe "#resolve" do
    let(:curation_session) { create(:curation_session) }
    let(:other_curation_session) { create(:curation_session) }
    let(:mutation_string) do
      <<~GQL
        {
          curationSessions(projectId: #{curation_session.project.id}){
            id
          }
        }
      GQL
    end

    context "with complete input" do
      before do
        other_curation_session # Create to test that no curation sessions of other projects are retrieved
        query mutation_string
      end

      it "finds all CurationSession for a specific project" do
        expect(gql_response.data["curationSessions"].map { |x| x["id"].to_i }).to eq [curation_session.id]
      end

      it "returns no errors" do
        expect(gql_response.errors).to eq nil
      end
    end
  end
end
