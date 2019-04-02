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

# == Schema Information
#
# Table name: companies
#
#  id                             :integer         not null, primary key
#  user_id                        :integer
#  name                           :string
#  contact_first_name             :string
#  contact_last_name              :string
#  street                         :string
#  state                          :string
#  zipcode                        :string
#  phone                          :string
#  mobile                         :string
#  dispatch_phone                 :string
#  website                        :string
#  description                    :text
#  reservation_notification       :hstore
#  blackout_dates                 :text
#  airports                       :text
#  hours_of_operation             :string
#  hours_in_advance_to_accept_rez :string
#  pickup_info                    :text
#  after_hours_info               :text
#  excess_luggage_charge          :string
#  luggage_insured                :boolean         default("false")
#  child_rate                     :string
#  child_car_seats_included       :boolean         default("false")
#  luggage_limitation_policy      :text
#  company_reservation_policy     :text
#  company_cancellation_policy    :text
#  child_safety_policy            :text
#  pet_car_seat_policy            :text
#  other_vehicle_types            :text
#  created_at                     :datetime
#  updated_at                     :datetime
#  vehicle_types                  :hstore
#  fax                            :string
#  city                           :string
#  active                         :boolean         default("true")
#  image_file_name                :string
#  image_content_type             :string
#  image_file_size                :integer
#  image_updated_at               :datetime
#  no_pickup_message              :string
#  active_to_airport              :boolean         default("true")
#  active_from_airport            :boolean         default("true")
#  commission                     :decimal(8, 2)   default("0.0")
#  payment_type                   :string
#

