require 'rails_helper'

RSpec.describe Company do
  it { expect(subject).to belong_to :user }
  it { expect(subject).to have_many :rates }
  it { expect(subject).to have_many :reservations }
  it { expect(subject).to have_many :payments }

  describe "validations" do
    described_class::REQUIRED_FIELDS.each do |name|
      it { expect(subject).to validate_presence_of(name) }
    end

    describe "hours_of_operation" do
      subject do
        build(:company,
          hours_of_operation: hours_of_operation,
          user: build(:user)
        )
      end

      %w'0400-0500 400-500 0400AM-0500PM 00 400'.each do |t|
        context "when invalid format #{t}" do
          let(:hours_of_operation) { t }

          it { expect(subject).not_to be_valid }
        end
      end

      %w'4:00AM-5:00PM 04:00AM-5:00PM 04:00AM-10:00PM'.each do |t|
        context "when valid format of #{t}" do
          let(:hours_of_operation) { t }

          it { expect(subject).to be_valid }
        end
      end
    end
  end

  describe "#notification_fax" do
    before do
      subject.notification_fax = 'true'
    end

    it { expect(subject.notification_fax).to eql 'true' }
  end

  describe "#notification_email" do
    before do
      subject.notification_email = 'true'
    end

    it { expect(subject.notification_email).to eql 'true' }
  end

  describe "#vehicle_types" do
    it "returns predefined list" do
      expect(
        subject.vehicle_types.map(&:attributes)
      ).to eql(described_class::VehicleType.predefined.map(&:attributes))
    end
  end

  describe "#vehicle_types_attributes=" do
    let(:attrs) do
      {'1' => { 'how_many' => '1', 'num_of_passengers' => '2' }}
    end
    let(:vehicle_type) { subject.vehicle_types.find{|vt| vt.id == 1} }

    before { subject.vehicle_types_attributes = attrs }

    it "has new values" do
      expect(vehicle_type.id).to eql 1
      expect(vehicle_type.how_many).to eql '1'
      expect(vehicle_type.num_of_passengers).to eql '2'
    end
  end

  describe "hours_of_operation" do
    subject do
      build(:company,
        hours_of_operation: "5:00AM - 6:00AM",
      )
    end

    context "hours of operation start" do
      it { expect(subject.hoo_start).to eql(Time.current.beginning_of_day + 5.hour) }
    end

    context "hours of operation end" do
      it { expect(subject.hoo_end).to eql(Time.current.beginning_of_day + 6.hour) }
    end
  end
end
