class AddUserIdAndRestaurantIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :user_id, :integer
    add_column :entries, :restaurant_id, :integer
  end
end
