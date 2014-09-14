class AddMissingFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :number, :integer
    add_column :users, :identity_number, :integer
    add_column :users, :address, :string
    add_column :users, :postal_address, :string
    add_column :users, :package1, :boolean
    add_column :users, :package2, :boolean
  end
end
