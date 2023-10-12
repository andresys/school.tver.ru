class CreateSchoolIndexImages < ActiveRecord::Migration
  def change
    create_table :school_index_images do |t|
      t.references :school
      t.string :title
      t.text :body
      t.attachment :image
      t.timestamps
    end
    add_index :school_index_images, :school_id
  end
end
