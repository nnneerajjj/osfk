class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :subject
      t.text :content
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end