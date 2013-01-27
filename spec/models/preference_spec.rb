require "spec_helper"

describe Preference do
  before(:each) do
    @pref = Preference.new
  end

  describe "Associations" do
    it "belongs_to a Restaurant" do
      @pref.restaurant = Restaurant.new
      @pref.should have(:no).errors_on(:restaraunt)
    end

    it "belongs_to a User" do
      @pref.user = User.new
      @pref.should have(:no).errors_on(:user)
    end
  end

  describe "Like/Dislike Method" do
    it "Like should default to false" do
      @pref.like.should be_false
    end

    it "Likes method should all return like as true" do
      Preference.likes.all? { |p| p.like == true }.should be_true
    end

    it "Dislikes method should all return like as false" do
      Preference.dislikes.all? { |p| p.like == true }.should be_false
    end 

    it "The count should equal the likes + dislikes" do
      Preference.count.should == Preference.likes.count + Preference.dislikes.count
    end
  end
end
