class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.references :page_navigation_link
      t.string :title
      t.text :body
      t.boolean :default, :default => false
      t.timestamps

    end
    add_index :static_pages, :page_navigation_link_id
  end
end
