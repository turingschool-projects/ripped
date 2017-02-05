require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe "statuses" do
    it { should define_enum_for(:status).with([:unstarted, :started, :attempted])}
  end
end