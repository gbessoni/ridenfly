class Rate < ActiveRecord::Base
  belongs_to :airport
  belongs_to :company
  has_many :pickup_times, class_name: 'Rate::PickupTime', dependent: :delete_all

  validates :airport, :company, presence: true
  validates :base_rate, :additional_passenger, presence: true, numericality: true
  validates :trip_duration, presence: true, numericality: {only_integer: true, greater_than: 0}
  validate :check_pickup_times

  PICKUP_TIMES_SEP = '|'

  accepts_nested_attributes_for :pickup_times, allow_destroy: true

  def pickup_time_list=(list)
    attrs = {}

    list = (list || '').split(PICKUP_TIMES_SEP).uniq.map(&:strip)
    list += [nil] * (pickup_times.size - list.size) if pickup_times.size > list.size

    list.zip(pickup_times).each_with_index do |(t, obj), i|
      oid = obj.try(:id) || i
      attrs[oid] ||= {}
      attrs[oid].merge!(id: oid) if obj.present?
      if t.present?
        attrs[oid].merge!(pickup_str: t)
      else
        attrs[oid].merge!(_destroy: 1)
      end
    end

    self.pickup_times_attributes = attrs
  end

  def pickup_time_list
    pickup_times.map(&:pickup_str).join(PICKUP_TIMES_SEP)
  end

  def airport_name
    airport.name
  end

  protected

  def check_pickup_times
    if pickup_times.any?{|pt| pt.errors.present?}
      errors.add(:pickup_time_list, :invalid_format)
    end
  end
end
