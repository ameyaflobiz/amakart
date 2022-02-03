class JsonbToString < ActiveRecord::Migration[6.0]
  def change
    change_column :images,:files,:string
  end
end
