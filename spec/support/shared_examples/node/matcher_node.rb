RSpec.shared_examples "validates like a matcher_node" do
  describe "#validate" do
    context "with valid input" do
      it "does validate" do
        expect(subject.validate).to eq true
      end

      it "does not have validation errors" do
        subject.validate
        expect(subject.errors.details).to be_empty
      end
    end

    context "with invalidated matcher_entries" do
      before do
        matcher_entry.errors.add(:node_key, :invalid_attribute_name)
        allow(matcher_entry).to receive(:validate).and_return false
      end

      it "merges the error details" do
        expect(subject.validate).to eq false
        expect(subject.full_errors_details[:matcher_entries]).to include(
          {
            node_key: [{ error: :invalid_attribute_name }]
          }
        )
      end
    end
  end
end
