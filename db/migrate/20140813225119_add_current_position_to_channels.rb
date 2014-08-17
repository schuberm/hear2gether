class AddCurrentPositionToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :currentPosition, :decimal
  end
end
