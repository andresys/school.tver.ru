class CreateTeacherMethodicLinks < ActiveRecord::Migration

  def change
    create_table :teacher_methodic_links, :id => false do |t|
      t.references :teacher
      t.references :methodic
    end
    add_index :teacher_methodic_links, [:teacher_id, :methodic_id], :unique => true
    add_index :teacher_methodic_links, [:methodic_id, :teacher_id], :unique => true
  end
end
