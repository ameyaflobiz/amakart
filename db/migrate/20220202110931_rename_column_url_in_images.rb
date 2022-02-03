class RenameColumnUrlInImages < ActiveRecord::Migration[6.0]
  def change
    rename_column :images, :url, :file
  end
end
