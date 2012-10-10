class AddTeamToInning < ActiveRecord::Migration
  def change
    add_column :innings, :team, :string

  end
end
