class AddPhony < ActiveRecord::Migration
  def change
    add_column :users, :country_code, :string
  end
end
