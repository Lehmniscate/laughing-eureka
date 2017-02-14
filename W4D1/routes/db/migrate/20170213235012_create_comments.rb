class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :author_id, null: false
      t.references :comment_id, polymorphic: true, index: true

      t.timestamps
    end
  end
end
