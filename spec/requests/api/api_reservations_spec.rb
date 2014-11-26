require 'rails_helper'

RSpec.describe "Api::Reservations" do
  let(:access_app) { create(:app, owner: create(:admin)) }
  let(:access_token) { create(:access_token, application: access_app) }
  let(:json_response) { JSON.parse response.body }

  describe "GET /api/1/reservations" do
    it "works!" do
      get api_reservations_url(format: :json, access_token: access_token.token)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/1/reservations" do
    let(:company) do
      create(:company, user: create(:user))
    end
    let(:airport) do
      create(:airport)
    end
    let(:rate) do
      create(:rate, airport: airport, company: company, base_rate: 20)
    end
    let(:reservations) do
      [{"addresss"=>"11 test", "airline"=>"ABX Air", "cross_street"=>"cross street", "flight_datetime"=>"2014-11-27 10:00AM",
        "flight_number"=>"12345", "gratuity"=>0.0, "luggage"=>0, "num_of_passengers"=>1,
        "passenger_name"=>"test test", "phone"=>"(123) 123-1231", "pickup_datetime"=>"2014-11-27 05:45AM", "rate_id"=>rate.id,
        "trip_direction"=>"to_airport"},
       {"addresss"=>"11 test", "airline"=>"Aer Lingus", "cross_street"=>"cross street",
        "flight_datetime"=>"2014-12-04 09:00PM", "flight_number"=>"54321", "gratuity"=>0.0, "luggage"=>0, "num_of_passengers"=>1,
        "passenger_name"=>"test test", "phone"=>"(123) 123-1231", "pickup_datetime"=>"2014-12-04 10:00PM", "rate_id"=>rate.id,
        "trip_direction"=>"from_airport"}
      ]
    end
    let(:reservation) do
      {rate_id: 1}
    end

    before do
      post api_reservations_url(
        format: :json,
        access_token: access_token.token,
        reservations: reservations
      )
    end

    it { expect(response).to have_http_status(201) }
    it { expect(json_response['reservations']).to be_present }
  end
end
