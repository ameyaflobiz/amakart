class RenameColumnOfImages < ActiveRecord::Migration[6.0]
  def change
    rename_column :images, :file, :files
  end
end
