require 'rails_helper'

RSpec.describe Company do
  describe "validations" do
    described_class::REQUIRED_FIELDS.each do |name|
      it { expect(subject).to validate_presence_of(name) }
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
      {'1' => { 'how_many' => '1', 'total_passengers' => '2' }}
    end
    let(:vehicle_type) { subject.vehicle_types.find{|vt| vt.id == 1} }

    before { subject.vehicle_types_attributes = attrs }

    it "has new values" do
      expect(vehicle_type.id).to eql 1
      expect(vehicle_type.how_many).to eql '1'
      expect(vehicle_type.total_passengers).to eql '2'
    end
  end
end
