class Audit::Action < ApplicationRecord
  belongs_to :created_by
  belongs_to :project  
  belongs_to :created_by,
             class_name: "User"

  validate :validate_meta
end
