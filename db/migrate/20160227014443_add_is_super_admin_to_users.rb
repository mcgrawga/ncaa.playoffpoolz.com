class AddIsSuperAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_super_admin, :integer
  end
end
