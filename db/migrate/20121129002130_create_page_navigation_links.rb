class CreatePageNavigationLinks < ActiveRecord::Migration
  def change
    create_table :page_navigation_links do |t|
      t.references :page_group
      t.string :title
      t.string :link
      t.boolean :default, :default => false
      t.integer :number
    end
    add_index :page_navigation_links, :page_group_id
  end
end
