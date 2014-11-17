require 'rails_helper'

RSpec.describe Import::Rate do
  let(:uploaded_file) do
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(
        Rails.root.join('spec/fixtures/csv/rates.csv')
      )
    )
  end

  subject do
    described_class.new(import_file: uploaded_file)
  end

  describe "import model" do
    it { expect(described_class.import_model).to eql(Rate) }
  end

  describe "#perform" do
    context "invalid objects" do
      before do
        subject.perform
      end

      it "has one object" do
        expect(subject.invalid_objects.size).to eql 1
        o = subject.invalid_objects.first

        expect(o.vehicle_type_passenger).to eql 'shared'
        expect(o.service_type).to eql 'private'
        expect(o.base_rate.to_f).to eql 10.0
        expect(o.additional_passenger.to_f).to eql 0.1
        expect(o.zipcode).to eql '123133'
        expect(o.hotel_landmark_name).to eql 'Vega'
        expect(o.hotel_landmark_street).to eql 'Grabiszynska'
        expect(o.hotel_landmark_city).to eql 'Wroclaw'
        expect(o.hotel_landmark_state).to eql 'Dolnyslask'
        expect(o.trip_duration).to eql 60
        expect(o.pickup_times.map(&:pickup_str)).to eql ["10:00PM", "11:00AM"]
      end
    end

    context "valid objects" do
      let(:company) do
        create(:company, name: 'My company', user: create(:user))
      end

      before do
        create(:airport, name: 'Cool JFK')
        subject.company_id = company.id
        subject.perform
      end

      it "has one object" do
        expect(subject.valid_objects.size).to eql 1
        o = subject.valid_objects.first

        expect(o.airport.name).to eql 'Cool JFK'
        expect(o.company.name).to eql 'My company'
      end
    end
  end
end
