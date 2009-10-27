class AddUserIdToRestaurants < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :user_id, :integer
  end

  def self.down
    remove_column :restaurants, :user_id
  end
end
