class AddLinkToLetter < ActiveRecord::Migration
  def change
    add_column :letters, :link, :string
  end
end
