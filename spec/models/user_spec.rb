require 'rails_helper'

RSpec.describe User do
  it { expect(subject).to have_one :company }
  it { expect(subject).to have_many :rates }
  it { expect(subject).to have_many :reservations }

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

# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string          default(""), not null
#  encrypted_password     :string          default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  roles                  :string          default("[]")
#

