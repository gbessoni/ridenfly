class Airport < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, length: {is: 3}, uniqueness: {scope: :state}

  scope :asc_by_name, ->{ order('name asc') }
end
