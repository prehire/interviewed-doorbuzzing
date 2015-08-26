class AddTimestamps < ActiveRecord::Migration
  def change
    add_column(:schedules, :created_at, :datetime)
    add_column(:schedules, :updated_at, :datetime)
  end
end
