require 'rails_helper'

RSpec.describe "Api::Availabilities" do
  let(:access_app) { create(:app, owner: create(:admin)) }
  let(:access_token) { create(:access_token, application: access_app) }
  let(:company) do
    create(:company, :with_vehicle_capacity_types,
      user: create(:user),
      hours_in_advance_to_accept_rez: 4,
      airport_pickup_fee: 2.1,
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
    let(:first_rate) { avls.first['rates'].first }

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

    context "scheduled" do
      let(:schd) { avls.select{|a| a['scheduled']} }

      let(:schd_params) do
        params.merge(
          search: {
            airport: airport.code,
            flight_time: 5.days.from_now,
            adults: 2,
            lat: 2.1,
            lng: 1.1
          }
        )
      end

      before do
        create(:rate,
          airport: airport,
          company: company,
          lat: 2.105, lng: 1.106,
          vehicle_type_passenger: Rate::SCHEDULED
        )
        get api_availabilities_url(schd_params)
      end

      it "returns one scheduled rate" do
        expect(schd.size).to eql 1
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

        expect(first_rate['trip_direction']).to eql Availability::Search::TO_AIRPORT
        expect(first_rate['base_rate']).to      eql "25.5"
        expect(first_rate['total_charge']).to   eql "25.5"
      end

      it "has company" do
        expect(first_rate['company']).to eql(
          "name"=>"MyString", "description"=>"MyText", "phone"=>"1231231312",
          "mobile"=>"12312312322", "dispatch_phone"=>"12312312234",
          "pickup_info"=>"MyText", "image_url"=>"http://www.example.com/system/image/test.png",
          "no_pickup_message"=>"We will call you one day before flight"
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
        expect(first_rate['trip_direction']).to eql Availability::Search::FROM_AIRPORT
        expect(first_rate['base_rate']).to      eql "25.5"
        expect(first_rate['total_charge']).to   eql "27.6"
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
        ).to be_blank
      end
    end

    context 'with rates with vehicle capacity type' do
      before do
        rate.dup.tap{ |r| r.vehicle_capacity_type = company.vehicle_types[0] }.save
        rate.dup.tap{ |r| r.vehicle_capacity_type = company.vehicle_types[1] }.save
      end

      context 'filter by 2 adults and 1 child' do
        before do
          params[:search].merge!(adults: 2, children: 1)
          get api_availabilities_url(params)
        end

        it 'show ' do
          expect(avls.size).to eql(company.rates.count)
        end
      end

      context 'filter by 6 adults' do
        before do
          params[:search].merge!(adults: 6, children: 0)
          get api_availabilities_url(params)
        end

        it 'show ' do
          expect(avls.size).to eql(2)
        end
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
