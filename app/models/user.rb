class User < ActiveRecord::Base
  acts_as_paranoid
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




# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string          default(""), not null
#  encrypted_password     :string          default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  roles                  :string          default("[]")
#  deleted_at             :datetime
#

