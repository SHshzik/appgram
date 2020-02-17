class ChangeStatusMessages < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :status, :boolean, default: false, null: false
  end
end
