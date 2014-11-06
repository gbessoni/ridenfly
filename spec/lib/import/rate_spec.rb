require 'rails_helper'

RSpec.describe Import::Rate do
  describe "import model" do
    it { expect(described_class.import_model).to eql(Rate) }
  end  
end
