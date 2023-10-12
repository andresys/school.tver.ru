class CreateTeacherSectionLinks < ActiveRecord::Migration
  def change
    create_table :teacher_section_links, :id => false  do |t|
      t.references :teacher
      t.references :section
    end
    add_index :teacher_section_links, [:section_id, :teacher_id], :unique => true
    add_index :teacher_section_links, [:teacher_id, :section_id], :unique => true
  end
end
