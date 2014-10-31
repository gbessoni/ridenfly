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
u.save!
