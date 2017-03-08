class ChangeForeignKeyName < ActiveRecord::Migration
  def change
    rename_column :steps, :todo_id, :todoId
  end
end
