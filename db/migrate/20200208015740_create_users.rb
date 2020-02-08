class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :phone
      t.string :email
      t.string :avatar

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :phone, unique: true
  end
end
