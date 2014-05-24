class ChangeRankingToSeatinTeams < ActiveRecord::Migration
  def change
		rename_column :teams, :ranking, :seat
		remove_column :teams, :wins
		remove_column :teams, :losses
		add_column :teams, :record, :string
  end
end
