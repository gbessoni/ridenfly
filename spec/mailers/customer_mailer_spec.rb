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

    it "has Total gross amount charged to customer" do
      expect(mail).to match /Total gross amount charged to customer/
    end

    it "has rez id" do
      expect(mail).to match /Reservation ID: RF123/
    end

    it "has passenger name in subject" do
      expect(
        described_class.reservation_email(reservation).subject
      ).to eql('New reservation for passenger passenger name')
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
