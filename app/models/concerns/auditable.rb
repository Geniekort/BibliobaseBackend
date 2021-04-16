module Auditable
  extend ActiveSupport::Concern

  included do
    has_many :actions,
             class_name: "Audit::Action",
             as: :resource
  end
end
