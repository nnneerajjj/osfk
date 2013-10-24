class AddHouseNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :house_number, :integer
  end
end
