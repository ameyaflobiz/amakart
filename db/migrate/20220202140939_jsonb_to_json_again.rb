class JsonbToJsonAgain < ActiveRecord::Migration[6.0]
  def change
    change_column :images,:files,:json
  end
end
