require 'rails_helper'

RSpec.describe "Api::Availabilities" do
  let(:access_app) { create(:app, owner: create(:admin)) }
  let(:access_token) { create(:access_token, application: access_app) }
  let(:company) do
    create(:company,
      user: create(:user),
      hours_in_advance_to_accept_rez: 4
    )
  end
  let(:airport) { create(:airport, code: 'JFK') }
  let(:rate) do
    create(:rate,
      zipcode: '10017',
      airport: airport,
      company: company,
      hotel_by_zipcode: true,
    )
  end
  let(:json_response) { JSON.parse response.body }
  let(:params) do
    { format: :json,
      access_token: access_token.token,
      search: {
        zipcode: rate.zipcode,
        airport: airport.code,
        flight_time: 5.days.from_now,
        adults: 2
      }
    }
  end

  before do
    allow_any_instance_of(Company).to receive(:image) do
      double(:image,
        flush_errors: '',
        dirty?: false, save: true,
        url: '/system/image/test.png'
      )
    end
  end

  describe "GET /api/1/availabilities" do
    let(:avls) { json_response['availabilities'] }

    context "when hotel zipcode provided" do
      let(:hotel_params) do
        params.merge(
          search: {
            hotel_landmark: 'name, street, city, state',
            hotel_landmark_zipcode: '10017',
            airport: airport.code,
            flight_time: 5.days.from_now,
            adults: 2,
            lat: 1,
            lng: 0.1
          }
        )
      end

      before { get api_availabilities_url(hotel_params) }

      it "returns hotel rates by zipcode" do
        expect(avls.size).to eql 1
      end
    end

    context "to few hours in advance to make a rez" do
      before do
        params[:search][:flight_time] = 1.hour.from_now
        get api_availabilities_url(params)
      end

      it "has reservation acceptance message" do
        expect(
          avls.first['rates'].first['rez_acceptance_message']
        ).to match(/we need 4 hours advanced/)
      end
    end

    context "from airport" do
      before do
        get api_availabilities_url(params)
      end

      it "returns to airport rate" do
        expect(avls.size).to eql(1)
        expect(avls.first['airport']).to be_present
        expect(
          avls.first['rates'].first['trip_direction']
        ).to eql Availability::Search::TO_AIRPORT
      end

      it "has company" do
        expect(avls.first['rates'].first['company']).to eql(
          "name"=>"MyString", "description"=>"MyText", "phone"=>"1231231312",
          "mobile"=>"12312312322", "dispatch_phone"=>"12312312234",
          "pickup_info"=>"MyText", "image_url"=>"http://www.example.com/system/image/test.png"
        )
      end
    end

    context "to airport" do
      before do
        params[:search].merge!(trip_direction: :from_airport)
        get api_availabilities_url(params)
      end

      it "returns to airport rate" do
        expect(avls.size).to eql(1)
        expect(
          avls.first['rates'].first['trip_direction']
        ).to eql Availability::Search::FROM_AIRPORT
      end
    end

    context "from airport roundtrip" do
      before do
        params[:search].merge!(return_flight_time: '2014-10-14 09:15:00')
        get api_availabilities_url(params)
      end

      it "returns to airport rate" do
        expect(avls.size).to eql(1)
        expect(avls.first['airport']).to be_present
        expect(
          avls.first['rates'].first['trip_direction']
        ).to eql Availability::Search::TO_AIRPORT
        expect(
          avls.first['rates'].last['trip_direction']
        ).to eql Availability::Search::FROM_AIRPORT
      end
    end

    context "to airport roundtrip" do
      before do
        params[:search].merge!(
          return_flight_time: '2014-10-14 09:15:00',
          trip_direction: :from_airport
        )
        get api_availabilities_url(params)
      end

      it "returns to airport rate" do
        expect(avls.size).to eql(1)
        expect(avls.first['airport']).to be_present
        expect(
          avls.first['rates'].first['trip_direction']
        ).to eql Availability::Search::FROM_AIRPORT
        expect(
          avls.first['rates'].last['trip_direction']
        ).to eql Availability::Search::TO_AIRPORT
      end

      it "has capacity eql to 4" do
        expect(
          avls.first['rates'].first['capacity']
        ).to eql Rate::CAPACITY
      end
    end
  end

  describe "GET /api/1/availabilities/:id" do
    let(:avl) { json_response['availability'] }

    context "to airport" do
      before do
        get api_availability_url(params.merge(id: rate.id))
      end

      it "returns to airport rate" do
        expect(avl['airport']).to be_present
        expect(
          avl['rates'].first['trip_direction']
        ).to eql Availability::Search::TO_AIRPORT
      end
    end
  end
end
