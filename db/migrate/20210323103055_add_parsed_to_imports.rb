class AddParsedToImports < ActiveRecord::Migration[6.1]
  def change
    add_column :imports, :parsed, :boolean, default: false
  end
end
