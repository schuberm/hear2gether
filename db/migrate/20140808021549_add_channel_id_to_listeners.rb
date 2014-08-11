class AddChannelIdToListeners < ActiveRecord::Migration
  def change
    add_column :listeners, :channel_id, :integer
  end
end
