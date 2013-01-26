class RemoveNameFromEntries < ActiveRecord::Migration
  def up
    remove_column :entries, :name
  end

  def down
    add_column :entries, :name, :string
  end
end
