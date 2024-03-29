require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:company) { build(:company) }
  subject { build(:payment, company: company) }

  it { expect(subject).to belong_to(:company) }
  it { expect(subject).to have_many(:reservations) }

  describe "#prepare_from_and_to" do
    subject do
      build(:payment, from: '2015-10-10 12:30', to: '2015-10-12 15:32', company: company)
    end

    before { subject.valid? }

    it { expect(subject.from).to eql Time.parse('2015-10-10 00:00:00 EDT') }
    it { expect(subject.to).to eql Time.parse('2015-10-12 23:59:59.999999999 EDT') }
  end

  describe "#prepare_amount" do
    before { subject.valid? }

    it { expect(subject.amount.to_f).to eql 0.0 }
  end

  describe "#check_company_payment_conflict" do
    let(:company) do
      create(:company, user: create(:user))
    end
    let(:payment_params) do
      { company: company, from: '2015-10-09 12:00', to: '2015-10-11 15:32' }
    end

    before do
      create(:payment, payment_params)
    end

    it "adds error" do
      payment = build(:payment, payment_params)
      expect(payment).to be_invalid
    end
  end
end


# == Schema Information
#
# Table name: payments
#
#  id             :integer         not null, primary key
#  company_id     :integer
#  from           :datetime
#  to             :datetime
#  amount         :decimal(8, 2)
#  paid           :boolean         default("false")
#  net_commission :decimal(8, 2)
#  created_at     :datetime
#  updated_at     :datetime
#  deleted_at     :datetime
#

