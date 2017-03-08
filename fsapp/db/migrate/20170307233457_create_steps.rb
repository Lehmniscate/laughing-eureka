class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :title
      t.boolean :done
      t.integer :todo_id

      t.timestamps null: false
    end
    add_index :steps, :todo_id
  end
end
