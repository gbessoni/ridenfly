class Reservation < ActiveRecord::Base
  belongs_to :company
  belongs_to :airport
end
