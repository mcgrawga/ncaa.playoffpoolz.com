class ChangeGroupToGroupNameInUser < ActiveRecord::Migration
  def change
		rename_column :users, :group, :group_name
  end
end
