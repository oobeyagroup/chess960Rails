class CreateStartingpositiondiscussions < ActiveRecord::Migration
  def change
    create_table :startingpositiondiscussions do |t|
      t.integer :startingpostionnumber
      t.string :startingposition
      t.string :comments

      t.timestamps
    end
  end
end
