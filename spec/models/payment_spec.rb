require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { expect(subject).to belong_to(:company) }
  it { expect(subject).to have_many(:reservations) }
end
