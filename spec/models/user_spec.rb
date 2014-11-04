require 'rails_helper'

RSpec.describe User do
  it { expect(subject).to have_one :company }
end
