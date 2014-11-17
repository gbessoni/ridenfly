require 'rails_helper'

RSpec.describe Availability::Search do
  it { expect(subject).to respond_to :airport }
  it { expect(subject.trip_direction).to eql described_class::TO_AIRPORT }
end
