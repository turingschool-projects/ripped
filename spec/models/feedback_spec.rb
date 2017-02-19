require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe "validations" do
    it "is invalid without a comment" do
      solution = create(:solution)
      user = create(:user)
      feedback = Feedback.create(solution_id: solution.id, user_id: user.id)
      expect(feedback).to_not be_valid
    end

    it "is invalid without a solution" do
      user = create(:user)
      feedback = Feedback.create(user_id: user.id, comment: "Comment comment")
      expect(feedback).to_not be_valid
    end

    it "is invalid without a user" do
      solution = create(:solution)
      feedback = Feedback.create(solution_id: solution.id, comment: "Comment comment")
      expect(feedback).to_not be_valid
    end

    it "is valid with all attributes" do
      solution = create(:solution)
      user = create(:user)
      feedback = Feedback.create(solution_id: solution.id, user_id: user.id, comment: "Comment comment")
      expect(feedback).to be_valid
    end
  end
  
  describe "relationships" do
    it "belongs to a user" do
      feedback = create(:feedback)
      expect(feedback).to respond_to(:user)
    end

    it "belongs to a solution" do
      feedback = create(:feedback)
      expect(feedback).to respond_to(:solution)
    end
  end
  
  describe "statuses" do
    it { should define_enum_for(:status).with([:unread, :read])}
  
    it "is created with the status of unread" do
      feedback = create(:feedback)
      expect(feedback.status).to eq("unread")
    end

    it "can have the status of read" do
      feedback = create(:feedback)
      expect(feedback.status).to eq("unread")
      feedback.status = 1
      expect(feedback.status).to eq("read")
    end
  end
end
