class AddRegularToUser < ActiveRecord::Migration
  def change
    add_column :users, :regular, :boolean, default: true
  end
end
