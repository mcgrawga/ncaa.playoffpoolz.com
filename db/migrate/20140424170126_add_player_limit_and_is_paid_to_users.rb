class AddPlayerLimitAndIsPaidToUsers < ActiveRecord::Migration
  def change
		add_column :users, :is_paid, :integer
		add_column :users, :player_limit, :integer
  end
end
