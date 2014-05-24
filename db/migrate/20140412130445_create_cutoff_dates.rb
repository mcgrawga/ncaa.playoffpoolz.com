class CreateCutoffDates < ActiveRecord::Migration
  def change
    create_table :cutoff_dates do |t|
      t.datetime :dt_time

      t.timestamps
    end
  end
end
