class ChangeUserIdentityNumberToString < ActiveRecord::Migration
  def change
    change_column :users, :identity_number, :string
  end
end
