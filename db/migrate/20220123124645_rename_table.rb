class RenameTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :stores, :sellers
  end
end
