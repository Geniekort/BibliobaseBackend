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
    association :created_data_object, factory: :data_object

    transient do
      project { nil }
    end

    trait :with_action do
      after :create do |curation_action, options|
        curation_action.action = create(:audit_action, project: options.project || create(:project))
      end
    end
  end
end
