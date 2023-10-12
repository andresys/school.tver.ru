class AddNumberStaticPage < ActiveRecord::Migration
  def up
  	change_table :static_pages do |t|
  		t.integer :number
  	end
  end

  def down
  end
end
