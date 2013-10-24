class RenameNumberToStreetNumber < ActiveRecord::Migration
  def change
    rename_column :users, :number, :street_number
  end
end
