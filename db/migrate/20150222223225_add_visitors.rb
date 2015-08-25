class AddVisitors < ActiveRecord::Migration
  def change
    create_table(:visitors) do |t|
      t.string :phone
      t.string :country_code

      t.timestamps
    end
  end
end
