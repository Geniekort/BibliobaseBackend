FactoryBot.define do
  factory :audit_resource_action, class: 'Audit::ResourceAction' do
    resource_id { 1 }
    resource_type { "Data::DataObject" }
    old_attributes { {} }
    new_attributes { {} }
    type { nil }
    meta { {} }
    created_by { build(:user) }
  end
end
