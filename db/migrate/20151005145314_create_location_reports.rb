class CreateLocationReports < ActiveRecord::Migration
  def change
    create_table :location_reports do |t|
      t.text :comment, default: "", null: false
      t.float :latitude
      t.float :longitude
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
