class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
	  t.string :title
	  t.references :school
	  t.integer :parent_id
      t.timestamps
    end
    add_index :folders, :school_id
  end
end
