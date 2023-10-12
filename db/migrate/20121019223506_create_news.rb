class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.references :school
      t.string :title
      t.text :description
      t.text :body
      t.string :youtube

      t.boolean :achiev_school
      t.boolean :achiev_section
      t.boolean :achiev_teacher
      t.boolean :achiev_pupil


      t.date :news_date
      t.timestamps
    end
    add_index :news, :school_id
  end
end
