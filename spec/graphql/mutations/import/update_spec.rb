require "rails_helper"

RSpec.describe Mutations::Import::Update do
  let(:subject) { described_class.new(object: nil, field: nil, context: {}) }

  describe "#resolve" do
    let(:input) do
      double(to_h: { meta: meta })
    end
    let(:meta) { { "format" => "csv" } }
    let(:import) { create(:import) }

    context "with parse_data=true" do
      it "parses the raw_data and sets parsed to true" do
        expect(import.parsed_data).to be nil
        subject.resolve(id: import.id, input: input, parse_data: true)

        import.reload
        expect(import.parsed_data).to be_an Array
        expect(import.parsed).to eq true
      end

      it "creates an import record for each row in the parsed data" do
        subject.resolve(id: import.id, input: input, parse_data: true)
        import.reload

        expect(import.import_records.count).to eq import.parsed_data.count
        expect(import.import_records.map(&:data)).to eq import.parsed_data
      end

      it "deletes existing import records " do
        import_record = create(:import_record, import: import)
        subject.resolve(id: import.id, input: input, parse_data: true)
        import.reload

        expect { import_record.reload }.to raise_error ActiveRecord::RecordNotFound
        expect(import.import_records.count).to eq import.parsed_data.count
        expect(import.import_records.map(&:data)).to eq import.parsed_data
      end

      context "if nothing changed while parsing the data" do
        it "Does not destroy existing import records" do
          subject.resolve(id: import.id, input: input, parse_data: true)
          import_records = import.import_records

          expect(import_records.length).to eq 2
          subject.resolve(id: import.id, input: input, parse_data: true)
          import_records.each do |import_record|
            expect { import_record.reload }.not_to raise_error
            expect(import_record.id).to be_a Numeric
          end
        end
      end
    end

    context "with parse_data=false" do
      it "does not parse the raw_data" do
        expect(import.parsed_data).to be nil
        subject.resolve(id: import.id, input: input, parse_data: false)

        import.reload
        expect(import.parsed_data).to be nil
        expect(import.parsed).to eq false
      end
    end
  end
end
