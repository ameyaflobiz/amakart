class RenameFilesToFile < ActiveRecord::Migration[6.0]
  def change
    rename_column :images, :files, :file
  end
end
