require "spec_helper"

describe Preference do
  before(:each) do
    @pref = Preference.new
  end

  describe "#like" do
    it "defaults to false" do
      @pref.like.should be_false
    end
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

  describe "Named scopes" do
    it "returns all `like == true` Preferences when calling #likes" do
      Preference.likes.all? { |p| p.like }.should be_true
    end

    it "returns all `like == false` Preferences when calling #dislikes" do
      Preference.dislikes.all? { |p| !p.like }.should be_true
    end
  end
end
