class Ransack::SearchDecorator < Draper::Decorator
  delegate_all

  def pickup_datetime_start
    if model.reservations_pickup_datetime_start_date_gteq.present?
      l model.reservations_pickup_datetime_start_date_gteq.try(:to_date)
    else
      nil
    end
  end

  def pickup_datetime_end
    if model.reservations_pickup_datetime_end_date_lteq.present?
      l model.reservations_pickup_datetime_end_date_lteq.try(:to_date)
    else
      nil
    end
  end
end
