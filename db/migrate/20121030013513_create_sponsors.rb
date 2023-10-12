class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :title
      t.string :sponsor_type
      t.string :sponsor_url
      t.references :school
    end
    add_index :sponsors, :school_id
  end
end
