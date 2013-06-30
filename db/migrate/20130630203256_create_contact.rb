class CreateContact < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, nil: false, required: true
      t.string :email, nil: false, required: true
      t.text :content, nil: false, required: true
      t.string :website

      t.timestamps
    end
  end
end
