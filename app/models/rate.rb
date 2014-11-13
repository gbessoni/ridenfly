class Rate < ActiveRecord::Base
  belongs_to :airport
  belongs_to :company

  validates :airport, :company, presence: true
  validates :base_rate, :additional_passenger, presence: true, numericality: true
  validates :trip_duration, presence: true, numericality: {only_integer: true, greater_than: 0}

  serialize :pickup_times, JSON

  PICKUP_TIMES_SEP = '|'

  def pickup_time_list=(list)
    self.pickup_times = (list || '').split(PICKUP_TIMES_SEP)
  end

  def pickup_time_list
    pickup_times.join(PICKUP_TIMES_SEP)
  end

  def airport_name
    airport.name
  end
end
