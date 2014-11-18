require 'rails_helper'

RSpec.describe Rate::PickupTime do
  describe "#pickup" do
    { '9:00' => 9,
      '10:00AM' => 10,
      '10:00PM' => 22,
      '9:00PM' => 21,
      '1000' => 10,
      '2200' => 22,
    }.each do |hour, expected_hour|
      it "returns seconds for '#{hour}'" do
        subject.pickup = hour
        expect(subject.pickup).to eql(expected_hour*3600)
      end
    end
  end

  describe "validations" do
    context "valid" do
      ['10:00AM', '10:00PM', '9:15PM', '9:20AM', '09:11PM'].each do |time|
        it "checks format of time '#{time}'" do
          subject.pickup_str = time
          expect(subject).to be_valid
        end
      end
    end

    context "invalid" do
      ['9:00 AM', '10:00 PM', '1000', '2200'].each do |time|
        it "checks format of time '#{time}'" do
          subject.pickup_str = time
          expect(subject).not_to be_valid
          expect(subject.errors[:pickup]).to include 'has invalid format'
        end
      end
    end
  end

  describe "#to_time" do
    before do
      allow(Time).to receive(:now) { Time.local(2014, 11, 18, 21, 0, 1) }
      subject.pickup = '9:00'
    end

    it { expect(subject.to_time).to eql(Time.parse('2014-11-18 09:00:00')) }
  end
end
