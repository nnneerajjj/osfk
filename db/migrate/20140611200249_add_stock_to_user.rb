class AddStockToUser < ActiveRecord::Migration
  def change
    add_column :users, :stock, :string
  end
end
