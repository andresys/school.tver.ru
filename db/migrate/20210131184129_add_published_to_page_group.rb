class AddPublishedToPageGroup < ActiveRecord::Migration
  def change
    add_column :page_groups, :published, :boolean, :default => true
  end
end
