class CreateScoreContents < ActiveRecord::Migration
  def change
    create_table :score_contents do |t|
      t.text :title
      t.string :team1
      t.string :team2
      t.text :match_status
      t.text :runrates

      t.timestamps
    end
  end
end
