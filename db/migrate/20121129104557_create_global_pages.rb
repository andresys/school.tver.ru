class CreateGlobalPages < ActiveRecord::Migration
  def change
    create_table :global_pages do |t|
      t.string :title
      t.text :body
      t.string :permalink

      t.timestamps
    end
  end
end
