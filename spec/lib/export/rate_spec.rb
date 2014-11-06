require 'rails_helper'

RSpec.describe Export::Rate do
  it { expect(described_class.columns.size).to eql 11 }

  subject { described_class.new [build(:rate)] }

  describe "#to_csv" do
    let(:csv) { subject.to_csv }

    it "has header row" do
      expect(csv).to match /Airport\*/
      expect(csv).to match /Trip duration/
    end

    it "has one rate" do
      expect(csv).to match /25.5/
      expect(csv).to match /60/
      expect(csv).to match /0.0;MyString/
    end
  end
end
