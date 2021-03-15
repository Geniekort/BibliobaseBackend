class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable # :trackable, :omniauthable
  include GraphqlDevise::Concerns::Model
end
