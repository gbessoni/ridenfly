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
end
