require 'rails_helper'

RSpec.describe Availability::PickupTime do
  def time(t)
    Time.parse(t)
  end

  describe "#working_hours?" do
    subject do
      described_class.new(
        start_datetime: time('2:00AM'),
        end_datetime:   time('2:15AM')
      )
    end

    it { expect(subject.in_working_hours?(
      time('1:00AM'), time('10:00PM')
    )).to eql true }

    it { expect(subject.in_working_hours?(
      time('2:00AM'), time('2:00PM')
    )).to eql true }

    it { expect(subject.in_working_hours?(
      time('2:15AM'), time('8:00AM')
    )).to eql true }

    it { expect(subject.in_working_hours?(
      time('0:00AM'), time('2:00AM')
    )).to eql true }

    it { expect(subject.in_working_hours?(
      time('0:00AM'), time('1:59AM')
    )).to eql false }

    it { expect(subject.in_working_hours?(
      time('2:16AM'), time('3:00AM')
    )).to eql false }
  end
end
