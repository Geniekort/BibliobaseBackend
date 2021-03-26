class Import < ApplicationRecord
  belongs_to :project
  has_many :import_records, dependent: :destroy

  validates :name, presence: true
end
