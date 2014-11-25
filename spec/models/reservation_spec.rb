require 'rails_helper'

RSpec.describe Reservation do
  it { expect(subject).to belong_to :rate }
end
