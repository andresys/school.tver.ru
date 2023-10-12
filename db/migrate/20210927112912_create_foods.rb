class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.date :date
      t.integer :menu_type
      t.attachment :file
      t.references :school

      t.timestamps
    end
    add_index :foods, :school_id
  end
end
