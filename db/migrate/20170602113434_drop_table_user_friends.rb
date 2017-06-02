class DropTableUserFriends < ActiveRecord::Migration[5.1]
  def change
  	drop_table :user_friends
  end
end
