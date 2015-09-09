class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.attachment :logo
      t.string :url
      t.integer :position

      t.timestamps
    end
  end
end
