class Rate < ActiveRecord::Base
  belongs_to :airport
  belongs_to :company

  validates :base_rate, :airport, :company, presence: true

  serialize :pickup_times, JSON

  PICKUP_TIMES_SEP = '|'

  def pickup_time_list=(list)
    self.pickup_times = list.split(PICKUP_TIMES_SEP)
  end

  def pickup_time_list
    pickup_times.join(PICKUP_TIMES_SEP)
  end
end
