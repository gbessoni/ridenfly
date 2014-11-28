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
