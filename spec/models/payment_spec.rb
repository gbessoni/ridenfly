require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { expect(subject).to belong_to(:company) }
end
