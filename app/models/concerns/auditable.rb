module Auditable
  extend ActiveSupport::Concern

  has_many :resource_actions,
    class_name: "Audit::ResourceAction",
    as: :resource
end
