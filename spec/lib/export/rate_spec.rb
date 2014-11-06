require 'rails_helper'

RSpec.describe Export::Rate do
  it { expect(described_class.columns.size).to eql 11 }
end
