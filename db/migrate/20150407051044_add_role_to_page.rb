class AddRoleToPage < ActiveRecord::Migration
  def change
    add_column :pages, :role_id, :integer
  end
end
