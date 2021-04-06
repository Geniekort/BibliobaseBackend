FactoryBot.define do
  factory :curation_session do
    project
    data_type
    import
    association :started_by, factory: :user
  end
end
