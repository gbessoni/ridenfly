class Rate::PickupTime < ActiveRecord::Base
  time_of_day_attr :pickup, format: :us

  FORMAT_REGEXP = /\d+{1,2}:\d{2}(AM|PM)/

  validate :check_pickup_str_format, if: proc{|r| r.pickup_str.present?}

  def pickup_str=(str)
    @pickup_str = str
    self.pickup = str
  end

  def pickup_str
    @pickup_str ||= TimeOfDayAttr.l(self.pickup)
  end

  def to_time
    Time.now.beginning_of_day + pickup.to_i
  end

  protected

  def check_pickup_str_format
    errors.add(:pickup, :invalid_format) unless pickup_str =~ FORMAT_REGEXP
  end
end
