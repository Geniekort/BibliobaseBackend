require "rails_helper"

RSpec.describe Audit::CurationAction, type: :model do
  describe "validations" do
    let(:subject) { build(:audit_resource_action, :curation_action) }
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

    describe "resource" do
      context "without a valid resource definition" do
        before do
          subject.resource = nil
        end

        it "raises a validation error" do
          expect(subject.validate).to eq false
          expect(subject.errors.details[:resource]).to include({ error: :blank })
        end
      end

      context "with an invalid resource class" do
        before do
          subject.resource_type = "BlablaNonSense"
        end

        it "raises a validation error" do
          pending "Not sure how to enforce a nice validation error instead of an Uninitialized Constant exception"
          expect(subject.validate).to eq false
          expect(subject.errors.details[:resource]).to include({ error: :invalid_type })
        end
      end
    end
  end
end
