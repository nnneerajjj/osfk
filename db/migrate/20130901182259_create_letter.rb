class CreateLetter < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.integer :user_id, null: false
      t.string :subject, null: false
      t.text :content, null: false
      t.boolean :send_after_save

      t.timestamps
    end
  end
end
