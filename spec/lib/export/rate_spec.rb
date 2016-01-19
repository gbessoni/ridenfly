require 'rails_helper'

RSpec.describe Export::Rate do
  it { expect(described_class.columns.size).to eql 16 }

  subject { described_class.new [build(:rate, airport: build(:airport))] }

  describe "#to_csv" do
    let(:csv) { subject.to_csv }

    it "has header row" do
      expect(csv).to match /ID/
      expect(csv).to match /Airport\*/
      expect(csv).to match /Trip duration/
      expect(csv).to match /Latitude, Longitude/
    end

    it "has one rate" do
      expect(csv).to match /JFK/
      expect(csv).to match /25.5/
      expect(csv).to match /60/
      expect(csv).to match /0.0,90102/
      expect(csv).to match /10:00AM|11:00PM/
      expect(csv).to match /"10.1, 20.2"/
    end
  end
end
