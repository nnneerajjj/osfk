class AddPageIdToPage < ActiveRecord::Migration
  def change
    add_reference :pages, :page, index: true
  end
end
