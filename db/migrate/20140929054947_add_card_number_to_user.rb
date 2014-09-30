class AddCardNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :card_number, :integer
    add_column :users, :home_phone, :string
  end
end
