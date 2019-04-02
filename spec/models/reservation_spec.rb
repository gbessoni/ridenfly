require 'rails_helper'

RSpec.describe Reservation do
  it { expect(subject).to belong_to :rate }

  describe "#total_net_fare" do
    subject { build(:reservation, net_fare: 32.4) }

    context "oneway" do
      it "returns net fare value" do
        expect(subject.total_net_fare).to eql 32.4
      end
    end

    context "roundtrip" do
      before do
        subject.sibling = build(:reservation, net_fare: 33.5)
      end

      it "returns net fare as sum of two rez" do
        expect(subject.total_net_fare.to_f).to eql 65.9
      end
    end
  end
end

# == Schema Information
#
# Table name: reservations
#
#  id                 :integer         not null, primary key
#  flight_datetime    :datetime
#  pickup_datetime    :datetime
#  passenger_name     :string
#  phone              :string
#  adults             :integer
#  net_fare           :decimal(8, 2)
#  gratuity           :decimal(8, 2)   default("0.0")
#  address            :string
#  cross_street       :string
#  airline            :string
#  luggage            :integer         default("0")
#  cancelation_reason :string
#  flight_number      :string
#  status             :string          default("active")
#  trip_direction     :string          default("to_airport")
#  created_at         :datetime
#  updated_at         :datetime
#  sibling_id         :integer
#  rate_id            :integer
#  children           :integer         default("0")
#  email              :string
#  flight_type        :string          default("domestic")
#

