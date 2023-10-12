class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :surname
      t.string :name
      t.string :experience
      t.string :clafication
      t.string :post #Должность
      t.text :about_teacher
      t.text :achiev
      t.text :contact
      t.attachment :photo
      t.references :teacher_group

      t.timestamps
    end
    add_index :teachers, :teacher_group_id
  end
end
