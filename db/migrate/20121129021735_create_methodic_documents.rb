class CreateMethodicDocuments < ActiveRecord::Migration
  def change
    create_table :methodic_documents do |t|
      t.references :teacher
      t.string :title
      t.text :description
      t.date :date
      t.attachment :file
      t.timestamps
    end
    add_index :methodic_documents, :teacher_id
  end
end
