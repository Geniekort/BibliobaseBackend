require "rails_helper"

RSpec.describe Service::Import::Parse::CsvParser do
  let(:meta) { {} }
  let(:import) { build(:import, meta: meta) }
  let(:subject) { described_class.new(import) }

  context "with default column separator" do
    context "without headers present" do
      it "parses with string indices as keys" do
        subject.perform
        expect(import.parsed_data).to eq(
          [
            {
              "0" => "column0",
              "1" => "column1"
            },
            {
              "0" => "column10",
              "1" => "column11"
            }
          ]
        )
      end
    end

    context "with headers present" do
      let(:meta) { { "headers" => true } }

      it "parses with first row values as keys" do
        subject.perform
        expect(import.parsed_data).to eq(
          [{
            "column0" => "column10",
            "column1" => "column11"
          }]
        )
      end
    end
  end

  [",", ";", "\t"].each do |separator|
    context "with specified column separator '#{separator}" do
      before(:each) do
        import.raw_data = %(column0#{separator}column1)
        import.meta = { "column_separator" => separator }
      end

      it "parses values correctly" do
        subject.perform
        expect(import.parsed_data).to eq(
          [{
            "0" => "column0",
            "1" => "column1"
          }]
        )
      end
    end
  end
end
