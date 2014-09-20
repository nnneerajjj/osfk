class CreateSlide < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :header, nil: false
      t.string :header2, nil: false
      t.text :content, nil: false
      t.string :link
    end
  end
end
