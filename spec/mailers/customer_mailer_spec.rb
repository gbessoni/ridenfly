require "rails_helper"

RSpec.describe CustomerMailer do
  describe "#reservation_email" do
    let(:reservation) do
      build(:reservation,
        id: 123,
        rate: build(:rate,
          airport: build(:airport),
          company: build(:company,
            user: build(:user, email: 'test@test.com'))))
    end
    let(:mail) do
      described_class.reservation_email(reservation).body.to_s
    end

    it "has body" do
      expect(mail).to match /#{reservation.rezid}/
    end
  end
end
