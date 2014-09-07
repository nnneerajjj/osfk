class Uploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.references :uploader, polymorphic: true
      t.string :type
      t.string :uuid

      t.timestamps
    end

    add_index :uploads, [:uploader_id, :uploader_type]
  end
end
