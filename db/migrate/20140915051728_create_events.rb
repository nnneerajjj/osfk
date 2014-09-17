class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :created_by_id, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.string :location
      t.string :address

      t.string :subject, null: false
      t.text :content
      t.string :slug

      t.timestamps
    end

    add_index :events, :slug, unique: true
  end
end
