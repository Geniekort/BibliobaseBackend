class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable # :trackable, :omniauthable
  include GraphqlDevise::Concerns::Model

  has_many :created_resource_actions,
    class_name: "Audit::ResourceAction",
    foreign_key: "created_by_id"
end
