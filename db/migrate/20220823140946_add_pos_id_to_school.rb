class AddPosIdToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :pos_id, :string, default: nil
  end
end
