class Airport < ActiveRecord::Base
  acts_as_paranoid
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, length: {is: 3}, uniqueness: {scope: :state}

  scope :asc_by_name, ->{ order('name asc') }
end




# == Schema Information
#
# Table name: airports
#
#  id             :integer         not null, primary key
#  name           :string
#  street_address :string
#  city           :string
#  state          :string(2)
#  zipcode        :string(5)
#  code           :string(3)
#  created_at     :datetime
#  updated_at     :datetime
#  timezone       :string
#  deleted_at     :datetime
#

