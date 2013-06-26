class AddKeyToPage < ActiveRecord::Migration
  def change
    add_column :pages, :key, :string
  end
end
