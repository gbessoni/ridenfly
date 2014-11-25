require 'rails_helper'

RSpec.describe Availability::TimesGenerator do
  def time(str)
    Time.parse(str)
  end

  let(:search)      { build(:availability_search) }
  let(:rate)        { build(:rate) }
  let(:flight_time) { time('2014-10-11 21:15:00') }

  subject { described_class.new(flight_time, search, rate) }

  context "when rate has pickup times" do
    let(:rate) { build(:rate, pickup_time_list: '10:00AM|11:00PM') }

    it "returns rate pickup times" do
      expect(subject.generate).to eql([
        { start_datetime: time('2014-10-11 10:00:00'),
          end_datetime: time('2014-10-11 10:00:00')},
        { start_datetime: time('2014-10-11 23:00:00'),
          end_datetime: time('2014-10-11 23:00:00')
        }
      ])
    end
  end

  context "when rate has no pickup times" do
    let(:rate) { build(:rate, trip_duration: 45, pickup_time_list: '') }

    context "and domestic flight" do
      it "has one pair 1,5h before flight plus trip duration" do
        expect(subject.generate).to include(
          { start_datetime: time('2014-10-11 18:45:00'),
            end_datetime: time('2014-10-11 19:00:00'),
          }
        )
      end
    end

    context "and international flight" do
      before { search.flight_type = Availability::Search::INTERNATIONAL }

      it "has one pair 2,5h before flight plus trip duration" do
        expect(subject.generate).to include(
          { start_datetime: time('2014-10-11 17:45:00'),
            end_datetime: time('2014-10-11 18:00:00'),
          }
        )
      end
    end
  end

  context "when from_airport direction" do
    before { search.trip_direction = Availability::Search::FROM_AIRPORT }

    it "returns flight time" do
      expect(subject.generate).to eql([
        { start_datetime: time('2014-10-11 21:15:00'),
          end_datetime: time('2014-10-11 21:15:00'),
        }
      ])
    end
  end

  context "#interval_times_attrs" do
    let(:times) { subject.interval_times_attrs(time('2014-10-12 18:00')) }

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
