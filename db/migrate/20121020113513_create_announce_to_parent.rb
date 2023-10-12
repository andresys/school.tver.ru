class CreateAnnounceToParent < ActiveRecord::Migration
  def change
    create_table :announce_to_parents do |t|
      t.references :school
      t.string :title
      t.text :description
      t.text :body
      t.string :youtube
      
      t.date :news_date
      t.timestamps
    end
    add_index :announce_to_parents, :school_id
  end
end
