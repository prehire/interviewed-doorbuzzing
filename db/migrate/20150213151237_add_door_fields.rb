class AddDoorFields < ActiveRecord::Migration

  def change
    add_column :users, :phone_inbound, :string
    add_column :users, :plan_name, :string
    add_column :users, :dtmf, :string
    add_column :users, :timezone, :string
 
    create_table(:destinations) do |t|
      t.integer :user_id
      t.string :name
      t.string :phone
      t.integer :sequence

      t.timestamps
    end
    add_index :destinations, :user_id
    add_foreign_key :destinations, :users

    create_table :schedules do |t|
      t.integer :user_id
      t.time :start_time
      t.time :end_time
      t.integer :day_of_week
    end
    add_index :schedules, :user_id
    add_foreign_key :schedules, :users

    create_table(:codes) do |t|
      t.integer :user_id
      t.string :name
      t.string :code

      t.timestamps
    end
    add_index :codes, :user_id
    add_foreign_key :codes, :users

  end

end
