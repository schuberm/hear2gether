class AddDjToListeners < ActiveRecord::Migration
  def change
    add_column :listeners, :dj, :boolean
  end
end
