require 'rails_helper'

RSpec.describe Availability::TimesGenerator do
  def time(str)
    Time.parse(str)
  end

  let(:search)      { build(:availability_search) }
  let(:rate)        { build(:rate) }
  let(:flight_time) { time('2014-10-11 21:15:00') }

  subject { described_class.new(flight_time, search, rate) }

  let(:times) { subject.generate.map(&:as_json) }

  context "when rate has pickup times" do
    let(:rate) { build(:rate, to_airport_pickup_time_list: '10:00AM|11:00PM') }

    it "returns rate pickup times" do
      expect(times).to eql([
        { start_datetime: time('2014-10-11 10:00:00'),
          end_datetime: time('2014-10-11 10:00:00')},
        { start_datetime: time('2014-10-11 23:00:00'),
          end_datetime: time('2014-10-11 23:00:00')
        }
      ])
    end
  end

  context "when rate has no pickup times" do
    let(:rate) { build(:rate, trip_duration: 45, to_airport_pickup_time_list: '') }

    context "and domestic flight" do
      it "has one pair 1,5h before flight plus trip duration" do
        expect(times).to include(
          { start_datetime: time('2014-10-11 18:45:00'),
            end_datetime: time('2014-10-11 19:00:00'),
          }
        )
      end
    end

    context "and international flight" do
      before { search.flight_type = Availability::Search::INTERNATIONAL }

      it "has one pair 2,5h before flight plus trip duration" do
        expect(times).to include(
          { start_datetime: time('2014-10-11 17:45:00'),
            end_datetime: time('2014-10-11 18:00:00'),
          }
        )
      end
    end
  end

  context "when from_airport direction" do
    before do
      search.trip_direction = Availability::Search::FROM_AIRPORT
      rate.from_airport_pickup_times = []
    end

    context "when from airport is not set" do
      it "returns flight time" do
        expect(times).to eql([
          { start_datetime: time('2014-10-11 21:15:00'),
            end_datetime: time('2014-10-11 21:15:00'),
          }
        ])
      end
    end

    context "when from airport pickup times present" do
      before do
        rate.from_airport_pickup_time_list = '10:00AM|11:00PM'
      end

      it "returns from airport pickup times" do
        expect(times).to eql([
          { start_datetime: time('2014-10-11 10:00:00'),
            end_datetime: time('2014-10-11 10:00:00'),
          },{
            start_datetime: time('2014-10-11 23:00:00'),
            end_datetime: time('2014-10-11 23:00:00'),
          }
        ])
      end
    end
  end

  context "#interval_times_attrs" do
    let(:times) do
      subject.interval_times_attrs(time('2014-10-12 18:00'))
        .map(&:as_json)
    end

    it "returns 4 time pairs" do
      expect(times).to eql([
        { start_datetime: time('2014-10-12 17:45:00'),
          end_datetime: time('2014-10-12 18:00:00'),
        },
        { start_datetime: time('2014-10-12 17:30:00'),
          end_datetime: time('2014-10-12 17:45:00'),
        },
        { start_datetime: time('2014-10-12 17:15:00'),
          end_datetime: time('2014-10-12 17:30:00'),
        },
        { start_datetime: time('2014-10-12 17:00:00'),
          end_datetime: time('2014-10-12 17:15:00'),
        }
      ])
    end
  end
end
