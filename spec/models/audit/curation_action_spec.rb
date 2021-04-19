require "rails_helper"

RSpec.describe Audit::CurationAction, type: :model do
  describe "validations" do
    let(:subject) { build(:curation_action) }

    it "validates correctly" do
      expect(subject.validate).to eq true
    end

    context "with invalid curation_type" do
      before do
        subject.curation_type = "Dance"
      end

      it "raises a validation error" do
        expect(subject.validate).to eq false
        expect(subject.errors.details[:curation_type]).to include(error: :inclusion, value: "Dance")
      end
    end

    context "with missing curation_session" do
      before do
        subject.curation_session = nil
      end

      it "raises a validation error" do
        expect(subject.validate).to eq false
        expect(subject.errors.details[:curation_session]).to include(error: :blank)
      end
    end

    describe "import_record validations" do
      context "with missing import_record" do
        before do
          subject.import_record_id = nil
        end

        it "raises a validation error" do
          expect(subject.validate).to eq false
          expect(subject.errors.details[:import_record]).to include(error: :blank)
        end
      end

      context "with import_record not corresponding to the import of the curation session" do
        before do
          wrong_import_record = create(:import_record)
          subject.import_record_id = wrong_import_record.id
        end
        
        it "raises a validation error" do
          expect(subject.validate).to eq false
          expect(subject.errors.details[:import_record]).to include(error: :blank)
        end
      end
    end
  end
end
