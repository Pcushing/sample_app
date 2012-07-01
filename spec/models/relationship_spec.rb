# == Schema Information
#
# Table name: relationships
#
#  id          :integer         not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Relationship do

  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  # What's going on here?  I can't seem to get this test to pass to confirm deleting a user deletes their relationships
  it "should destroy associated relationships" do
    follower.destroy
    relationships.each do |relationship|
      Relationship.find_by(relationship.follower_id).should be_nil
    end
  end
  
  # Use as a guide for the above
  # it "should destroy associated microposts" do
  #   microposts = @user.microposts
  #   @user.destroy
  #   microposts.each do |micropost|
  #     Micropost.find_by_id(micropost.id).should be_nil
  #   end
  # end

  describe "accessible attributes" do
    it "should not allow access to follower_id" do
      expect do
        Relationship.new(follower_id: follower.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "follower methods" do    
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should == follower }
    its(:followed) { should == followed }
  end
  
  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end
end
