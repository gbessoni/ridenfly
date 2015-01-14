class Rate < ActiveRecord::Base
  include Rate::Relations
  include Rate::Validations
  include Rate::Scopes

  PICKUP_TIMES_SEP = '|'

  HOTEL_LANDMARK_ATTRS = [
    :hotel_landmark_name,
    :hotel_landmark_street,
    :hotel_landmark_city,
    :hotel_landmark_state
  ]

  CAPACITY = 4

  before_save :set_hl_words

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

  def capacity
    CAPACITY
  end

  def lat_lng
    [lat, lng].reject(&:blank?).join(', ')
  end

  def lat_lng=(arg)
    self.lat, self.lng = arg.to_s.split(',').map(&:strip)
  end

  def hotel_landmark
    [  hotel_landmark_name,
       hotel_landmark_street, 
       hotel_landmark_city,
       hotel_landmark_state
    ].reject(&:blank?).join(', ')
  end

  def rez_acceptable?(time)
    hours_in_advance = (
      Time.zone.now + company.hours_in_advance_to_accept_rez.to_i.hours
    )
    time >= hours_in_advance
  end

  def distance
    attributes['distance']
  end

  protected

  def set_hl_words
    self.hl_words = Rate::WordsBuilder.new(
      [hotel_landmark_name, hotel_landmark_street].join ' '
    ).words
  end
end
