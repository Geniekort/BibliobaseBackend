FactoryBot.define do
  factory :audit_action, class: 'Audit::Action' do
    created_by { build(:user) }
    project
    type { nil }
    meta { {}  }

    trait :curation_action do
      initialize_with { Audit::CurationAction.new(attributes) }
      type { "Audit::CurationAction" }
      meta{ { curation_type: "Create" } }
    end
  end
end
