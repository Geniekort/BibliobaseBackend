require "rails_helper"

require_relative "../../../support/graphql_helpers"

include GraphQL::TestHelpers

RSpec.describe "Queries ExecuteQuery" do
  describe "#resolve" do
    let(:data_type) { create(:data_type) }
    let(:query_string) do
      "SOME_QUERY_STRING"
    end

    let(:quoted_query_string) { "\"#{query_string}\"" }

    let(:mutation_string) do
      <<~GQL
        {
          executeQuery(queriedDataTypeId: #{data_type.id}, queryString: #{quoted_query_string}){
            id
          }
        }
      GQL
    end

    context "with complete input" do
      let(:fake_data_object) { create(:data_object) }

      it "returns the data objects found by the query executor and no errors" do
        executor_double = double
        expect(Query::Executor).to receive(:new).with(data_type, query_string).and_return executor_double
        expect(executor_double).to receive(:execute).and_return [fake_data_object]

        query mutation_string

        expect(gql_response.data["executeQuery"].map { |x| x["id"].to_i }).to eq [fake_data_object.id]
        expect(gql_response.errors).to eq nil
      end

    end
  end
end
