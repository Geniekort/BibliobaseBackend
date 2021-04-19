FactoryBot.define do
  factory :audit_action, class: 'Audit::Action' do
    created_by { build(:user) }
    project
    type { nil }
    meta { {}  }

  end

  factory :curation_action, class: "Audit::CurationAction" do
    curation_type { "Create" }
    curation_session
    import_record { create(:import_record, import: curation_session.import) }
  end
end
