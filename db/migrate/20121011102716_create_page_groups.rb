class CreatePageGroups < ActiveRecord::Migration
  def change
    create_table :page_groups do |t|
      t.references :school
      t.string :title
      t.string :content_type

      t.boolean :default, :default => false
      t.integer :number

      t.attachment :image
    end
    add_index :page_groups, :school_id
  end
end
