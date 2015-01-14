require 'rails_helper'

RSpec.describe Availability::Scheduled do
  it { expect(subject).to respond_to(:lat, :lng, :schd_distance) }
end
