require "rails_helper"

RSpec.describe Audit::ResourceAction, type: :model do
  # describe "validations" do
  #   let(:subject) { build(:audit_resource_action) }
  #   describe "meta validations" do
  #   end

  #   describe "resource" do
  #     context "without a valid resource definition" do
  #       before do
  #         subject.resource = nil
  #       end

  #       it "raises a validation error" do
  #         expect(subject.validate).to eq false
  #         expect(subject.errors.details[:resource]).to include({ error: :blank })
  #       end
  #     end

  #     context "with an invalid resource class" do
  #       before do
  #         subject.resource_type = "BlablaNonSense"
  #       end

  #       it "raises a validation error" do
  #         pending "Not sure how (and whether) to enforce a nice validation error instead of an Uninitialized Constant exception"
  #         expect(subject.validate).to eq false
  #         expect(subject.errors.details[:resource]).to include({ error: :invalid_type })
  #       end
  #     end
  #   end
  # end
end
