class User < ActiveRecord::Base
  include User::Roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :company
  has_many :rates, through: :company
  has_many :reservations, through: :company
  has_many :oauth_apps, class_name: 'Doorkeeper::Application', as: :owner

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
