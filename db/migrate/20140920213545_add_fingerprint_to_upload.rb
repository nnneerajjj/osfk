class AddFingerprintToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :file_fingerprint, :string
  end
end
