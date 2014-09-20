class AddColumnToEvent < ActiveRecord::Migration
  def change
    add_column :events, :can_participate, :boolean, default: :false
  end
end
