module Auditable
  extend ActiveSupport::Concern

  included do
    has_many :resource_actions,
             class_name: "Audit::ResourceAction",
             as: :resource
  end
end
