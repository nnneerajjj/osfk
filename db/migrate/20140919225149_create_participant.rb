class CreateParticipant < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.timestamps
    end

    add_index :participants, [:user_id, :event_id], unique: true
  end
end
