# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.where(email: 'admin@ridenfly.com').first_or_initialize
u.password = 'ridenfly.123'
u.password_confirmation = 'ridenfly.123'
u.roles = [User::ADMIN]
u.save!

companies_data = File.open(
  Rails.root.join('db/legacy_data/companies.yml')
){|f| f.read}
companies_data.gsub!('!ruby/object:Company', "")

YAML.load(companies_data).each do |company|
  cc = company['attributes']

  email = cc['email'].split(',').first
  email = email.split(' ').first.downcase
  p email

  c = Company.joins(:user).where(
    'users.email' => email
  ).first_or_initialize

  c.user = User.where(
    email: email
  ).first_or_initialize
  c.user.password = 'ridenfly.123'
  c.user.password_confirmation = 'ridenfly.123'
  c.user.roles = [User::COMPANY]

  c.name = cc['name']
  c.contact_first_name = cc['first_name']
  c.contact_last_name = cc['last_name']

  c.street = 'undefined'
  c.city = 'undefined'
  c.state = 'undefined'
  c.zipcode = 'undefined'

  c.phone = '000 000 0000' #cc['phone']
  c.mobile = cc['cell_phone']
  c.dispatch_phone = '000 000 0000' # no dispatch phone
  c.website = [cc['web'], 'undefined'].reject(&:blank?).first
  c.description = [cc['description'], 'undefined'].reject(&:blank?).first

  c.notification_fax = cc['fax'].present?
  c.fax = cc['fax']
  c.notification_email = true

  c.blackout_dates = cc['blackout']
  c.airports = [cc['airports_serviced'], 'undefined'].reject(&:blank?).first
  c.hours_of_operation = [cc['biz_hours_start'], cc['biz_hours_end']].join(' - ')
  c.hours_in_advance_to_accept_rez = cc['hours_in_advance']
  c.pickup_info = [cc['arrival_and_airport_pickup_info'], 'undefined'].reject(&:blank?).first
  c.after_hours_info = cc['after_hour_and_waiting_time']

  c.excess_luggage_charge = cc['excess_luggage_charge']
  c.luggage_insured = (cc['insured'] == "Yes")
  c.child_rate = cc['children_rate']
  c.child_car_seats_included = cc['child_car_seats']

  c.luggage_limitation_policy = cc['luggage_limitation_policy']
  c.company_reservation_policy = cc['confirm_reservation_policy']
  c.company_cancellation_policy = cc['cancellation_policy']
  c.child_safety_policy = cc['children_safety_policy']
  c.pet_car_seat_policy = cc['car_seats_pets']
  c.other_vehicle_types = cc['upcharge_for_vehicle_upgrade']

  c.save!
end if false

airports_data = File.open(
  Rails.root.join('db/legacy_data/airports.yml')
){|f| f.read}
airports_data.gsub!('!ruby/object:Airport', "")

YAML.load(airports_data).each do |airport|
  aa = airport['attributes']
  p aa['name']

  a = Airport.where(name: aa['name']).first_or_initialize
  a.street_address = aa['street_address']
  a.city  = aa['city']
  a.name = aa['name']
  a.code = aa['code'].try(:gsub, /\)|\(/, '')
  a.zipcode  = aa['zip']
  a.state = aa['state']
  a.save(validate: false)
end if false

# Generate reservations
27.times do |i|
  t = rand(100).days.from_now
  r = Reservation.new(
    rate: Rate.order('random()').first,
    flight_datetime: t,
    pickup_datetime: (t - 2.hours),
    passenger_name: "User#{rand(100)} Name",
    status: 'active',
    phone: '+112312312' + rand(1000).to_s,
    adults: (rand(5) + 1),
    gratuity: rand(10).to_f + (rand(100) / 100.0),
    net_fare: rand(100).to_f + (rand(100) / 100.0),
    address: rand(1000).to_s + ' test street',
    cross_street: rand(1000).to_s + ' cross street',
    airline: 'ABX Air',
    flight_number: rand(1000)
  )
  r.save!
end
