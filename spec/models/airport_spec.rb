require 'rails_helper'

RSpec.describe Airport do
  describe "validations" do
    [:name, :code].each do |name|
      it { expect(subject).to validate_presence_of(name) }
    end
  end
end


# == Schema Information
#
# Table name: airports
#
#  id             :integer         not null, primary key
#  name           :string
#  street_address :string
#  city           :string
#  state          :string(2)
#  zipcode        :string(5)
#  code           :string(3)
#  created_at     :datetime
#  updated_at     :datetime
#  timezone       :string
#
# Indexes
#
#  index_airports_on_name            (name) UNIQUE
#  index_airports_on_state_and_code  (state,code) UNIQUE
#

