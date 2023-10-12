class CreateCreations < ActiveRecord::Migration
  def change
    create_table :creations do |t|
      t.references :school
      t.string :title
      t.text :description
      t.text :body
      t.string :youtube
      
      t.date :news_date
      t.timestamps
    end
    add_index :creations, :school_id
  end
end
