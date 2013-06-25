class AddVisibleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :public, :boolean, null: false, default: false
  end
end
