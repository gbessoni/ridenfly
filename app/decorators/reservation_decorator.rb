class ReservationDecorator < Draper::Decorator
  delegate_all

  def airport_name
    [ model.to_airport? ? 'D-' : 'A-',
      model.airport_name
    ].join
  end

  def trip_direction
    model.trip_direction.camelcase
  end

  def full_address_location
    address
  end

  def pickup_datetime
    I18n.l model.pickup_datetime, format: :std
  end

  def flight_datetime
    I18n.l model.flight_datetime, format: :std
  end
end
