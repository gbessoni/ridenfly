class Rate < ActiveRecord::Base
  belongs_to :airport
  belongs_to :company

  validates :base_rate, :airport, :company, presence: true

  serialize :pickup_times, JSON

  def pickup_time_list=(list)
    self.pickup_times = list.split('|')
  end

  def pickup_time_list
    pickup_times.join('|')
  end
end
