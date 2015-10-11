class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.belongs_to :user, index: true
      t.string :status
      t.decimal :amount
      t.string :url

      t.timestamps
    end
  end
end
