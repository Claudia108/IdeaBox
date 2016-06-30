# require 'rails_helper'
#
# RSpec.describe Idea, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
require 'rails_helper'

RSpec.describe Idea, type: :model do
  context "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  context "enum" do
    it "defines quality with enum" do
      should define_enum_for(:quality).
      with([:swill, :plausible, :genius])
    end

    it "has a default of swill" do
      idea = create(:idea)
      expect(idea.swill?).to be true
    end
  end
end
