class ModifyImageTable < ActiveRecord::Migration[6.0]
  def change
    change_column :images,:file,:jsonb, using: 'file::jsonb'
  end
end
