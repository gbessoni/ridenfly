require 'rails_helper'

RSpec.describe Availability::Item do
  subject { build(:availability_item, search: search, rate: rate) }

  describe "#pickup_times" do
    let(:rate) do
      build(:rate, company:
        build(:company, hours_in_advance_to_accept_rez: 12)
      )
    end
    let(:search) do
      build(:availability_search, flight_time: 5.hours.from_now)
    end

    it "has empty list" do
      expect(subject.pickup_times).to eql []
    end
  end

  describe "#rates" do
    let(:search) do
      build(:availability_search, flight_time: 5.hours.from_now)
    end

    let(:rate) do
      build(:rate, company: build(:company))
    end

    context "one way" do
      context "to airport" do
        before do
          search.trip_direction = Availability::Search::TO_AIRPORT
        end

        context "when active to airport is true" do
          it "has one rate" do
            expect(subject.rates.size).to eql 1
          end
        end

        context "when active to airport is false" do
          before { subject.company.active_to_airport = false }

          it "has no rates" do
            expect(subject.rates.size).to eql 0
          end
        end
      end

      context "from airport" do
        before do
          search.trip_direction = Availability::Search::FROM_AIRPORT
        end

        context "when active from airport is true" do
          it "has one rate" do
            expect(subject.rates.size).to eql 1
          end
        end

        context "when active from airport is false" do
          before { subject.company.active_from_airport = false }

          it "has no rates" do
            expect(subject.rates.size).to eql 0
          end
        end
      end
    end

    context "roundtrip" do
      before do
        search.return_flight_time = 24.hours.from_now
      end

      context "to airport" do
        before do
          search.trip_direction = Availability::Search::TO_AIRPORT
        end

        context "when active to airport and active from airport is true" do
          it "has two rates" do
            expect(subject.rates.size).to eql 2
          end
        end

        context "when active to airport is false" do
          before { subject.company.active_to_airport = false }

          it "has no rates" do
            expect(subject.rates.size).to eql 0
          end
        end

        context "when active from airport is false" do
          before { subject.company.active_from_airport = false }

          it "has no rates" do
            expect(subject.rates.size).to eql 0
          end
        end

        context "when both directions not active" do
          before do
            subject.company.active_to_airport = false
            subject.company.active_from_airport = false
          end

          it "has zero rates" do
            expect(subject.rates.size).to eql 0
          end
        end
      end

      context "from airport" do
        before do
          search.trip_direction = Availability::Search::FROM_AIRPORT
        end

        context "when active to airport and active from airport is true" do
          it "has two rates" do
            expect(subject.rates.size).to eql 2
          end
        end

        context "when active to airport is false" do
          before { subject.company.active_to_airport = false }

          it "has no rates" do
            expect(subject.rates.size).to eql 0
          end
        end

        context "when active from airport is false" do
          before { subject.company.active_from_airport = false }

          it "has no rates" do
            expect(subject.rates.size).to eql 0
          end
        end
      end
    end
  end
end
