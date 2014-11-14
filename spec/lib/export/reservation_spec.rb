require 'rails_helper'

RSpec.describe Export::Reservation do
  it { expect(described_class.columns.size).to eql 13 }

  subject { described_class.new [build(:reservation, airport: build(:airport))] }

  describe "#to_csv" do
    let(:csv) { subject.to_csv }

    it "has header row" do
      expect(csv).to match /Rez ID/
    end

    it "has one rate" do
      expect(csv).to match /9.99/
    end
  end
end
