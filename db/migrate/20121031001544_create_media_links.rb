class CreateMediaLinks < ActiveRecord::Migration
  def change
    create_table :media_links do |t|
      t.string :title
      t.string :url
      t.string :url_source
      t.datetime :date_public
      t.references :school

      t.timestamps
    end
    add_index :media_links, :school_id
  end
end
