class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.attachment :image

      t.integer :parent_of_image_id
      t.string  :parent_of_image_type

      t.timestamps
    end
  end
end
