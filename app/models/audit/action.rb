class Audit::Action < ApplicationRecord
  belongs_to :project
  belongs_to :created_by,
             class_name: "User"
  belongs_to :action_detailer,
             polymorphic: true,
             optional: true

  validate :validate_meta

  def validate_meta
    true
  end
end
