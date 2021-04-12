require "rails_helper"

RSpec.describe Audit::CurationAction, type: :model do
  describe "validations" do
    let(:subject) { build(:audit_action, :curation_action) }
    describe "meta validations" do
      context "with a complete meta definition" do
        it "validates correctly" do
          expect(subject.validate).to eq true
        end
      end

      context "with missing curation_type" do
        before do
          subject.meta = {}
        end

        it "raises a validation error" do
          expect(subject.validate).to eq false
          expect(subject.errors.details[:meta]).to include({ error: :invalid_curation_type })
        end
      end

      context "with invalid curation_type" do
        before do
          subject.meta = { "curation_type" => "Dance" }
        end

        it "raises a validation error" do
          expect(subject.validate).to eq false
          expect(subject.errors.details[:meta]).to include({ error: :invalid_curation_type })
        end
      end
    end
  end
end
