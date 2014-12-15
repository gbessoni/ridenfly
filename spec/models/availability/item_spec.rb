require 'rails_helper'

RSpec.describe Availability::Item do
  describe "#pickup_times" do
    let(:rate) do
      build(:rate, company:
        build(:company, hours_in_advance_to_accept_rez: 12)
      )
    end
    let(:search) do
      build(:availability_search, flight_time: 5.hours.from_now)
    end

    subject { build(:availability_item, search: search, rate: rate) }

    it "has empty list" do
      expect(subject.pickup_times).to eql []
    end
  end
end
