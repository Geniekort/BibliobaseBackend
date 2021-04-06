require "rails_helper"

require_relative "../../../support/graphql_helpers"

include GraphQL::TestHelpers

RSpec.describe Mutations::CurationSession::Delete, type: :request do
  describe "#resolve" do
    let(:curation_session) { create(:curation_session) }
    let(:mutation_string) do
      <<~GQL
        {
          curationSession(id: #{curation_session.id}){
            id
            project {
              id
            }
            import {
              id
            }
            dataType {
              id
            }
          }
        }
      GQL
    end

    context "with complete input" do
      before do
        query mutation_string
      end

      it "finds a curation_session" do
        expect(gql_response.data["curationSession"]).to eq({
          "id" => curation_session.id.to_s,
          "project" => {"id" => curation_session.project.id.to_s },
          "import" => {"id" => curation_session.import.id.to_s },
          "dataType" => {"id" => curation_session.data_type.id.to_s }
        })
      end

      it "returns no errors" do
        expect(gql_response.errors).to eq nil
      end
    end
  end
end
