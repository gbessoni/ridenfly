require 'rails_helper'

RSpec.describe Rate do
  it { expect(subject).to belong_to :airport }
  it { expect(subject).to belong_to :company }
end
