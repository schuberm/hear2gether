class AddQueryscToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :querysc, :string
  end
end
