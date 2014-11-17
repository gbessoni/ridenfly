require 'rails_helper'

RSpec.describe Rate do
  it { expect(subject).to belong_to :airport }
  it { expect(subject).to belong_to :company }
  it { expect(subject).to have_many :pickup_times }

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
end
