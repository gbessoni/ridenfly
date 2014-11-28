class RateDecorator < Draper::Decorator
  delegate_all

  def hotel_landmark
    [  hotel_landmark_name,
       hotel_landmark_street, 
       hotel_landmark_city,
       hotel_landmark_state
    ].reject(&:blank?).join(', ')
  end
end
