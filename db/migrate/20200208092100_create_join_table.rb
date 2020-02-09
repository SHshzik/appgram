class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :rooms do |t|
      t.index [:room_id, :user_id]
    end
  end
end
