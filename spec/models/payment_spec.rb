require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { expect(subject).to belong_to(:company) }
  it { expect(subject).to have_many(:reservations) }

  subject { build(:payment) }

  describe "#prepare_from_and_to" do
    subject do
      build(:payment, from: '2015-10-10 12:30', to: '2015-10-12 15:32')
    end

    before { subject.valid? }

    it { expect(subject.from).to eql Time.parse('2015-10-10 00:00:00 EDT') }
    it { expect(subject.to).to eql Time.parse('2015-10-12 23:59:59.999999999 EDT') }
  end

  describe "#prepare_amount" do
    before { subject.valid? }

    it { expect(subject.amount.to_f).to eql 0.0 }
  end
end
