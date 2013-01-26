require "spec_helper"

describe User do
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :remember_me }
  it { should respond_to :name }
  it { should respond_to :preferences }
  it { should respond_to :restaurants }

  before(:each) do
    @user = User.new
  end

  describe "Associations" do
    before(:each) do
      @user.preferences << Preference.new
    end

    it "has_many Preferences" do
      @user.should have(:no).errors_on(:preferences)
    end

    it "has_many Restaurants" do
      @user.preferences.last.restaurant = Restaurant.new
      @user.should have(:no).errors_on(:restaurants)
    end
  end
end
