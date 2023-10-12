class CreateNewsLinks < ActiveRecord::Migration
  def change
    create_table :news_links do |t|
      t.references :news
      t.integer :link_id
      t.string  :link_type
    end
    add_index :news_links, :news_id
  end
end
