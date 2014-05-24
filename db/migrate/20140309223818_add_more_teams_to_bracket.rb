class AddMoreTeamsToBracket < ActiveRecord::Migration
  def change
    add_column :brackets, :round2_team3, :integer
    add_column :brackets, :round2_team4, :integer
    add_column :brackets, :round2_team33, :integer
    add_column :brackets, :round2_team34, :integer
    add_column :brackets, :round2_team35, :integer
    add_column :brackets, :round2_team36, :integer
    add_column :brackets, :round3_team1, :integer
    add_column :brackets, :round3_team2, :integer
    add_column :brackets, :round3_team17, :integer
    add_column :brackets, :round3_team18, :integer
    add_column :brackets, :round4_team1, :integer
    add_column :brackets, :round4_team9, :integer
  end
end
