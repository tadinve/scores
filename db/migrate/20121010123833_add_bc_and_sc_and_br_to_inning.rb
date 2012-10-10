class AddBcAndScAndBrToInning < ActiveRecord::Migration
  def change
    add_column :innings, :bc, :float

    add_column :innings, :sc, :float

    add_column :innings, :br, :float

  end
end
