class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.integer :round2_team1
      t.integer :round2_team2
      t.integer :user_id

      t.timestamps
    end
  end
end
