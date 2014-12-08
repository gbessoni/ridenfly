require "rails_helper"

RSpec.describe CustomerMailer do
  let(:reservation) do
    build(:reservation,
      id: 123,
      cancelation_reason: 'it a test',
      rate: build(:rate,
        airport: build(:airport),
        company: build(:company,
          user: build(:user, email: 'test@test.com'))))
  end

  describe "#reservation_email" do
    let(:mail) do
      described_class.reservation_email(reservation).body.to_s
    end

    it "has body" do
      expect(mail).to match /#{reservation.rezid}/
    end
  end

  describe "#cancelation_email" do
    let(:mail) do
      described_class.cancelation_email(reservation).body.to_s
    end

    it "has body" do
      expect(mail).to match /#{reservation.rezid}/
    end

    it "has cancelation reason" do
      expect(mail).to match /#{reservation.cancelation_reason}/
    end
  end
end
