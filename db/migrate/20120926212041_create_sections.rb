class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :school
      t.string :title
      t.string :year
      t.integer :count
      t.string :description
      t.text :body
      t.string :type_of_section
      t.attachment :image

      t.timestamps
    end
    add_index :sections, :school_id
  end
end
