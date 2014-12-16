require 'rails_helper'

RSpec.describe Rate do
  it { expect(subject).to belong_to :airport }
  it { expect(subject).to belong_to :company }
  it { expect(subject).to have_many :pickup_times }
  it { expect(subject).to have_many :reservations }

  describe "validations" do
    before do
      subject.hotel_by_zipcode = true
    end

    it "checks presence of zipcode when hotel_by_zipcode" do
      expect { subject.valid? }.to change{ subject.errors[:zipcode] }
    end
  end

  describe "#pickup_time_list" do
    context "separator" do
      before do
        subject.pickup_time_list = '1:00AM|10:00PM|10:00AM'
      end

      it "has pickup times in seconds" do
        expect(subject.pickup_times.map(&:pickup)).to eql([3600, 79200, 36000])
      end
    end
  end

  describe "#lat_lng" do
    subject { build(:rate) }

    context "reader" do
      it { expect(subject.lat_lng).to eql '10.1, 20.2' }
    end

    context "writer" do
      before { subject.lat_lng = '10.5,5.6' }

      it { expect(subject.lat_lng).to eql '10.5, 5.6' }
    end
  end

  describe "#hl_words" do
    subject { build(:rate) }

    before { subject.send(:set_hl_words) }

    it { expect(
      subject.hl_words
    ).to eql '6 73 grabiszynska vega' }
  end

  describe "scopes" do
    let(:airport) { create(:airport) }
    let(:company) { create(:company, user: create(:user)) }

    describe "#by_geo_and_distance" do
      let(:rates) do
        [ create(:rate, lat: 1.00090, lng: 1.00090, company: company, airport: airport),
          create(:rate, lat: 1.00095, lng: 1.00095, company: company, airport: airport)
        ]
      end

      before do
        rates
      end

      it "returns 2 rates within 100meters" do
        expect(
          described_class.by_geo_and_distance(1.00093, 1.00093, 100).size
        ).to eql 2
      end

      it "returns 1 rate within 10meters" do
        expect(
          described_class.by_geo_and_distance(1.000951, 1.000951, 5).size
        ).to eql 1
      end
    end

    describe "#by_hotel_landmark_words" do
      let(:rate) do
        create(:rate,
          company: company,
          airport: airport,
          hotel_landmark_name: 'Vega',
          hotel_landmark_street: 'Grabiszynska 73 / 6'
        )
      end

      before { rate }

      it "returns hotel for '6 73 grabiszynska vega'" do
        expect(
          described_class.by_hotel_landmark_words(
            '6 73 grabiszynska vega'
          )
        ).to be_present
      end

      it "does not return hotel for 'dolnyslask grabiszynska'" do
        expect(
          described_class.by_hotel_landmark_words(
            'dolnyslask grabiszynska'
          )
        ).to be_blank
      end

      it "does not return hotel for '6 73 vega'" do
        expect(
          described_class.by_hotel_landmark_words(
            '6 73 vega'
          )
        ).not_to be_present
      end
    end
  end

  describe "#rez_acceptable?" do
    subject do
      build(:rate, company:
        build(:company, hours_in_advance_to_accept_rez: 12)
      )
    end

    before do
      allow(Time).to receive(:now) { Time.local(2014,12,12,10, 10, 1) }
    end

    context "when flight 12.hours.from_now" do
      it "returns true" do
        expect(subject.rez_acceptable?(12.hours.from_now)).to eql true
      end
    end

    context "when flight 13.hours.from_now" do
      it "returns true" do
        expect(subject.rez_acceptable?(13.hours.from_now)).to eql true
      end
    end

    context "when flight 10.hours.from_now" do
      it "returns false" do
        expect(subject.rez_acceptable?(10.hours.from_now)).to eql false
      end
    end
  end
end
