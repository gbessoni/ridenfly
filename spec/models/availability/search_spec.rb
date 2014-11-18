require 'rails_helper'

RSpec.describe Availability::Search do
  it { expect(subject).to respond_to :airport }
  it { expect(subject.trip_direction).to eql described_class::TO_AIRPORT }

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
end
