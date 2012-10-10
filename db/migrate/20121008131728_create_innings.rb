class CreateInnings < ActiveRecord::Migration
  def change
    create_table :innings do |t|
      t.string :player_name
      t.string :status
      t.integer :runs
      t.integer :minutes
      t.integer :balls
      t.integer :fours
      t.integer :sixes
      t.float :strike_rate
      t.integer :match_id

      t.timestamps
    end
  end
end
