class AddSentAtToLetter < ActiveRecord::Migration
  def change
    add_column :letters, :sent_to_all_at, :datetime
  end
end
