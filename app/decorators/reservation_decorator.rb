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
    [ addresss,
      [ rate.zipcode,
        rate.hotel_landmark_city
      ].reject(&:blank?).join(' '),
      rate.hotel_landmark_state
    ].reject(&:blank?).join(', ')
  end
end
