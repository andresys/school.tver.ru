class CreateMethodics < ActiveRecord::Migration
  def change
    create_table :methodics do |t|
      t.references :school
      t.string :title
      t.string :full_title
    end
    add_index :methodics, :school_id
  end
end
