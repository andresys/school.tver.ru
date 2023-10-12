class CreateAnnouncement < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :description
      t.text :body
      t.string :youtube
      t.text :location
      t.datetime :start_date
      t.datetime :end_date
      t.references :school

      t.timestamps
    end
    add_index :announcements, :school_id
  end
end

