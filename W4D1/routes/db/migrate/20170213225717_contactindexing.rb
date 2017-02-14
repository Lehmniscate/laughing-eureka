class Contactindexing < ActiveRecord::Migration
  def change
    add_index :contacts, [:email, :user_id], unique: true
    add_index :contacts, :user_id
  end
end
