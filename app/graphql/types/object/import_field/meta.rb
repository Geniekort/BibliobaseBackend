module Types::Object::ImportField
  class Meta < Types::BaseObject
    description "Meta field of the import"

    field :format, String, null: true
    field :headers, Boolean, null: true
    field :column_separator, String, null: true
  end
end
