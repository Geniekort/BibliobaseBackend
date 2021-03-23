FactoryBot.define do
  factory :import do
    name { "Test Import" }
    meta  { nil }
    raw_data { "column0,column1\ncolumn10,column11" }
    project
  end
end
