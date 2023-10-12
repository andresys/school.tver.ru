class CreateSimplyLinks < ActiveRecord::Migration
  def change
    create_table :simply_links do |t|
      t.string :link_url
      t.string :link_title

      t.integer :parent_link_page_id
      t.string  :parent_link_page_type
    end
  end
end
