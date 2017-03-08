class CreateTaggingsTable < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :todo_id
    end
  end
end
