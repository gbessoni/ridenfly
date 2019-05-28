require 'rails_helper'

RSpec.describe "Api::Reservations" do
  let(:access_app) { create(:app, owner: create(:admin)) }
  let(:access_token) { create(:access_token, application: access_app) }
  let(:json_response) { JSON.parse response.body }
  let(:company_user) { create(:user) }
  let(:company) { create(:company, user: company_user) }
  let(:airport) { create(:airport) }
  let(:rate) do
    create(:rate, airport: airport, company: company, base_rate: 20)
  end

  describe "GET /api/1/reservations" do
    it "works!" do
      get api_reservations_url(format: :json, access_token: access_token.token)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/1/reservations" do
    let(:reservations) do
      [{"address"=>"11 test", "airline"=>"ABX Air", "cross_street"=>"cross street", "flight_datetime"=>"2014-11-27 10:00AM",
        "flight_number"=>"12345", "gratuity"=>0.0, "luggage"=>0, "adults"=>1, "flight_type"=>"international",
        "passenger_name"=>"test test", "phone"=>"(123) 123-1231", "pickup_datetime"=>"2014-11-27 05:45AM", "rate_id"=>rate.id,
        "trip_direction"=>"to_airport", "email"=>"test@text.com"},
       {"address"=>"11 test", "airline"=>"Aer Lingus", "cross_street"=>"cross street",
        "flight_datetime"=>"2014-12-04 09:00PM", "flight_number"=>"54321", "gratuity"=>0.0, "luggage"=>0, "adults"=>1, "flight_type"=>"international",
        "passenger_name"=>"test test", "phone"=>"(123) 123-1231", "pickup_datetime"=>"2014-12-04 10:00PM", "rate_id"=>rate.id,
        "trip_direction"=>"from_airport", "email"=>"test@text.com"}
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

    it 'send confirmation mails' do
      last_mail = ActionMailer::Base.deliveries.last

      expect(last_mail.to).to eql([company_user.email])
      expect(last_mail.bcc).to eql(['test@test.com', 'test2@test.com'])
    end
  end

  describe "POST /api/1/reservations/:reservation_id/cancel" do
    let(:reservation) { create(:reservation, rate: rate) }
    let(:params) do
      { format: :json,
        access_token: access_token.token,
        reservation_id: reservation.id,
        reservation:{ cancelation_reason: 'it was a test' }
      }
    end

    context "successful" do
      before do
        post api_reservation_cancel_url(params)
      end

      it { expect(response).to be_success }
    end

    context "error" do
      before do
        post api_reservation_cancel_url(params.merge(reservation: {cancelation_reason: ''}))
      end

      it { expect(
        json_response['errors']
      ).to include("Cancelation reason can't be blank") }
    end
  end
end
