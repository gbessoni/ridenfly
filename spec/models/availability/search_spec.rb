require 'rails_helper'

RSpec.describe Availability::Search do
  it { expect(subject).to respond_to :airport }
  it { expect(subject.trip_direction).to eql described_class::TO_AIRPORT }

  describe "#distance" do
    it { expect(subject.distance).to eql 600.0 }
  end

  describe "#schd_distance" do
    it { expect(subject.schd_distance).to eql 48_280.32 }
  end

  describe "validations" do
    describe "zipcode blank" do
      before do
        subject.zipcode = ''
        subject.distance = ''
        subject.valid?
      end

      it "validates lat, lng and distance" do
        expect(subject.errors[:lat]).to be_present
        expect(subject.errors[:lng]).to be_present
        expect(subject.errors[:distance]).to be_present
      end
    end

    describe "zipcode present" do
      before do
        subject.zipcode = '10007'
        subject.distance = ''
        subject.valid?
      end

      it "validates lat, lng and distance" do
        expect(subject.errors[:lat]).not_to be_present
        expect(subject.errors[:lng]).not_to be_present
        expect(subject.errors[:distance]).not_to be_present
      end
    end
  end

  describe "#hotel_landmark" do
    let(:hotel_landmark) do
      'Vega,Grabiszynska,Wroclaw,Dolnyslask'
    end

    subject { build(:availability_search, hotel_landmark: hotel_landmark) }

    it { expect(subject.hotel_landmark).to eql hotel_landmark }
    it { expect(subject.hotel_landmark_name).to eql 'Vega' }
    it { expect(subject.hotel_landmark_street).to eql 'Grabiszynska' }
    it { expect(subject.hotel_landmark_city).to eql 'Wroclaw' }
    it { expect(subject.hotel_landmark_state).to eql 'Dolnyslask' }
  end

  describe "#roundtrip?" do
    context "when return flight time present" do
      before do
        subject.return_flight_time = Time.now
      end

      it "returns true" do
        expect(subject).to be_roundtrip
      end
    end

    context "when return flight time blank" do
      before do
        subject.return_flight_time = ''
      end

      it "returns false" do
        expect(subject).not_to be_roundtrip
      end
    end
  end

  describe "#second_leg" do
    context "when TO_AIRPORT" do
      let(:second_leg) { subject.second_leg }

      it "returns FROM_AIRPORT trip direction" do
        expect(second_leg.trip_direction).to eql described_class::FROM_AIRPORT
      end

      it "does not modify first leg" do
        second_leg
        expect(subject.trip_direction).to eql described_class::TO_AIRPORT
      end
    end
  end
end
