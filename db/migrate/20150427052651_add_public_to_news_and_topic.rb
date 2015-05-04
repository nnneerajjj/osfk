class AddPublicToNewsAndTopic < ActiveRecord::Migration
  def change
    add_column :news, :public, :boolean, null: false, default: false
    add_column :topics, :public, :boolean, null: false, default: false
    add_column :news, :role_id, :integer
    add_column :topics, :role_id, :integer
  end
end
