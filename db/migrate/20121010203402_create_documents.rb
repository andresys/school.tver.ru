class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.attachment :file
      t.integer :parent_page_id
      t.string  :parent_page_type
      t.timestamps
    end
  end
end
