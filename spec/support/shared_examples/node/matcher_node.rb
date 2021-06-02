RSpec.shared_examples "validates like a matcher_node" do |allowed_matcher_entry_data_attribute_type = []|
  describe "#validate" do
    context "with valid input" do
      it "does validate" do
        expect(subject.validate).to eq true
      end

      it "does not have validation errors" do
        subject.validate
        expect(subject.full_errors_details).to be_empty
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

    describe "matcher_entry validation" do
      allowed_matcher_entry_data_attribute_type.each do |data_attribute_type|
        let(:data_attribute) { build(:attribute, attribute_type: set_data_attribute_type) }
        let(:set_data_attribute_type) { data_attribute_type }

        before do
          matcher_entry.node_key = data_attribute.name
          allow(matcher_entry).to receive(:matching_data_attribute).and_return data_attribute
        end

        context "with matcher_entries with allowed data_attribute type '#{data_attribute_type}'" do
          it "does validate" do
            subject.validate
            expect(subject).to be_valid
            expect(subject.errors.details).to be_empty
          end
        end

        context "with matcher_entries with not allowed data_attribute type " do
          let(:set_data_attribute_type) { "FAKENEVERALLOWED" }

          it "does not validate" do
            expect(subject.validate).to eq false
            expect(subject.full_errors_details[:matcher_entries]).to include(
              :node_key => [{ error: :invalid_matching_data_attribute_type, matched_data_attribute_name: data_attribute.name }]
            )
          end
        end
      end
    end
  end
end
