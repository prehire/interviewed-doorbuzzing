class RenameCodePin < ActiveRecord::Migration
  def change
  	rename_column :codes, :code, :pin
  end
end
