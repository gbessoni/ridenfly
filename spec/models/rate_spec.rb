require 'rails_helper'

RSpec.describe Rate do
  it { expect(subject).to belong_to :airport }
  it { expect(subject).to belong_to :company }
  it { expect(subject).to have_many :pickup_times }
  it { expect(subject).to have_many :reservations }

  describe "#pickup_time_list" do
    context "separator" do
      before do
        subject.pickup_time_list = '1:00AM|10:00PM|10:00AM'
      end

      it "has pickup times in seconds" do
        expect(subject.pickup_times.map(&:pickup)).to eql([3600, 79200, 36000])
      end
    end
  end

  describe "#lat_lng" do
    subject { build(:rate) }

    context "reader" do
      it { expect(subject.lat_lng).to eql '10.1, 20.2' }
    end

    context "writer" do
      before { subject.lat_lng = '10.5,5.6' }

      it { expect(subject.lat_lng).to eql '10.5, 5.6' }
    end
  end

  describe "#hl_words" do
    subject { build(:rate) }

    before { subject.send(:set_hl_words) }

    it { expect(
      subject.hl_words
    ).to eql '6 73 dolnyslask grabiszynska vega wroclaw' }
  end
end
