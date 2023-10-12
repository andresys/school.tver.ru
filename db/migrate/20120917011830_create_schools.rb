class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.references :district
      t.string :permalink, {:default=>"", :null => false }
      t.string :title
      t.text :description
      t.text :text_about_page
      t.float :n_cordinate, :precision => 15, :scale => 12
      t.float :e_cordinate, :precision => 15, :scale => 12
      t.attachment :emblem

      # Contact
      t.string :mailto
      t.string :address, :default=>""
      t.string :phones, :default=>""
      t.string :other_contact, :default=>"", :limit => 500
      t.string :existing_site

      t.timestamps
    end
    add_index :schools, :district_id
    add_index(:schools, :permalink)
  end
end
