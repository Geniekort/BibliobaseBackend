class Audit::ResourceAction < ApplicationRecord
  include Audit::ActionDetailer

  ALLOWED_RESOURCE_TYPES = %w[
    Data::DataObject
    Data::DataType
    Data::DataAttribute
    CurationSession
    ImportRecord
    Import
    Project
    User
  ].freeze

  belongs_to :resource,
             polymorphic: true

  validates :resource_type, presence: true, inclusion: { in: ALLOWED_RESOURCE_TYPES }
  validate :validate_meta

  def validate_meta
    true
  end

  # Validate whether the resource is actually present
  def validate_resource
    unless resource_type.present? && resource_type.safe_constantize
      errors.add(:resource, :invalid_type)
      return false
    end

    unless resource.present?
      errors.add(:resource, :blank)
      return false
    end

    true
  end
end
