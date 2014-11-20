require 'rails_helper'

RSpec.describe "Api::Availabilities" do
  let(:company) { create(:company, user: create(:user)) }
  let(:airport) { create(:airport, code: 'JFK') }
  let(:rate) do
    create(:rate, zipcode: '10017', airport: airport, company: company)
  end
  let(:json_response) { JSON.parse response.body }

  describe "GET /api/1/availabilities" do
    let(:params) do
      { format: :json,
        search: {
          zipcode: rate.zipcode,
          airport: airport.code,
          flight_time: '2014-10-10 10:22:00',
          adults: 2
        }
      }
    end
    let(:avls) { json_response['availabilities'] }

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
    end
  end
end
