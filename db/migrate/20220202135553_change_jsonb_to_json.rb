class ChangeJsonbToJson < ActiveRecord::Migration[6.0]
  def change
    change_column :images,:files,:jsonb, using: 'files::json'
  end
end
