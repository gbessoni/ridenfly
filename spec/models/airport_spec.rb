require 'rails_helper'

RSpec.describe Airport do
  describe "validations" do
    [:name, :code].each do |name|
      it { expect(subject).to validate_presence_of(name) }
    end
  end
end
