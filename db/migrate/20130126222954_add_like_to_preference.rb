class AddLikeToPreference < ActiveRecord::Migration
  def change
    add_column :preferences, :like, :boolean, {null: false, default: false}
  end
end
