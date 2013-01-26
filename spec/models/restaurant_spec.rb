require "spec_helper"

describe Restaurant do
  it { should respond_to :name }
  it { should respond_to :entries }
  it { should respond_to :users }

  before(:each) do
    @restaurant = Restaurant.new
  end

  it "can be associated with an Entry" do
    @restaurant.entries << Entry.new
    @restaurant.should have(:no).errors_on(:entries)
  end

  it "can be associated with a User" do
    some_user = User.new
    some_entry = Entry.new
    some_entry.user = some_user
    @restaurant.entries << some_entry

    @restaurant.should have(:no).errors_on(:users)
  end
end
