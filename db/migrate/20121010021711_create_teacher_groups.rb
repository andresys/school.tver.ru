class CreateTeacherGroups < ActiveRecord::Migration
  def change
    create_table :teacher_groups do |t|
      t.string :title
      t.references :school
    end
    add_index :teacher_groups, :school_id
  end
end
