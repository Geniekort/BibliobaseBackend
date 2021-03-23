class Import < ApplicationRecord
  belongs_to :project
  has_many :import_records

  validates :name, presence: true
end
