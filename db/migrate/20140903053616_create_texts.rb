class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.references :page, null: false
      t.string :key, null: false
      t.text   :value, default: ''
    end
  end
end
