FactoryBot.define do
  factory :data_type, class: "Data::DataType" do
    project
    sequence(:name) { |n| "data_type_#{n}" }
  end

  factory :attribute, class: "Data::Attribute" do
    project
    data_type
    attribute_type { "Text" }
    sequence(:name) { |n| "attribute_name_#{n}" }
    trait :required do
      validation_definition do
        {
          presence: { condition: true }
        }
      end
    end
  end

  factory :data_object, class: "Data::DataObject" do
    project
    data_type
  end
end
