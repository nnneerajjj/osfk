class AddTitleToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :title, :string, default: ''
  end
end
