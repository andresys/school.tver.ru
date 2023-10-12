class AddSocLink < ActiveRecord::Migration
  def up
    change_table :schools do |t|
      t.string :vk
      t.string :facebook
      t.string :twitter
    end
  end

  def down
  end
end
