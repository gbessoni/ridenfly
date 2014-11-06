require 'rails_helper'

RSpec.describe User do
  it { expect(subject).to have_one :company }

  describe "roles" do
    context "admin" do
      it { expect(build(:admin)).to be_admin }
    end

    context "user with company role" do
      let(:user_comp) do
        build(:user, roles: [described_class::COMPANY])
      end

      it { expect(user_comp).to be_company }
    end
  end
end
