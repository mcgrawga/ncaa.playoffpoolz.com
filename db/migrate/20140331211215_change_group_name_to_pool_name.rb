class ChangeGroupNameToPoolName < ActiveRecord::Migration
  def change
		rename_column :users, :group_name, :pool_name
  end
end
