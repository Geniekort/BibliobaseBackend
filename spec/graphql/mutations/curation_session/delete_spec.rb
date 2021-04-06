require "rails_helper"

require_relative "../../../support/graphql_helpers"

include GraphQL::TestHelpers

RSpec.describe Mutations::CurationSession::Delete, type: :request do
  describe "#resolve" do
    let(:curation_session) { create(:curation_session)}
    let(:mutation_string) do
      <<~GQL
        mutation deleteCurationSession($id: ID!){
          deleteCurationSession(id: $id) {
            curationSession {
              id
            }
          }
        }
      GQL
    end

    context "with complete input" do
      before do
        mutation mutation_string,
                 variables: {
                   id: curation_session.id
                 }
      end

      it "deletes a CurationSession" do
        expect{ curation_session.reload }.to raise_error ActiveRecord::RecordNotFound
      end

      it "returns a CurationSession with the correct data" do
        expect(gql_response.data.dig("deleteCurationSession", "curationSession", "id").to_i).to eq curation_session.id
      end

      it "returns no errors" do
        expect(gql_response.errors).to eq nil
      end
    end
  end
end
