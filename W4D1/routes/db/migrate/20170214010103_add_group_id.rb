class AddGroupId < ActiveRecord::Migration
  def change
    add_column :contact_groups, :group_id, :integer
  end
end
