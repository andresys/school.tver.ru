class Findex < ActiveRecord::Migration
  def change
    create_table :findex do |t|
      t.attachment :file
      t.references :school

      t.timestamps
    end
    add_index :findex, :school_id
  end
end
