class Rate < ActiveRecord::Base
  belongs_to :airport
  belongs_to :company
  has_many :pickup_times, class_name: 'Rate::PickupTime', dependent: :delete_all

  validates :airport, :company, presence: true
  validates :base_rate, :additional_passenger, presence: true, numericality: true
  validates :trip_duration, presence: true, numericality: {only_integer: true, greater_than: 0}

  PICKUP_TIMES_SEP = '|'

  accepts_nested_attributes_for :pickup_times, allow_destroy: true

  def pickup_time_list=(list)
    delete_records = Hash[pickup_times.map do |t|
      [t.id.to_s, {id: t.id, _destroy: 1}]
    end]
    new_records = Hash[(list || '').split(PICKUP_TIMES_SEP).uniq
      .each_with_index.map do |t, i|
      [i, {pickup_str: t}]
    end]
    self.pickup_times_attributes = delete_records.merge new_records 
  end

  def pickup_time_list
    pickup_times.map(&:pickup_str).join(PICKUP_TIMES_SEP)
  end

  def airport_name
    airport.name
  end
end
