class AddWaterToUser < ActiveRecord::Migration
  def change
    add_column :users, :water, :string
  end
end
