require 'rails_helper'

RSpec.describe Reservation do
  it { expect(subject).to belong_to :company }
  it { expect(subject).to belong_to :airport }
  it { expect(subject).to belong_to :sibling }
end
