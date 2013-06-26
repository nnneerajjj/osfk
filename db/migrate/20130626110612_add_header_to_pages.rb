class AddHeaderToPages < ActiveRecord::Migration
  def change
    add_column :pages, :header, :string
  end
end
