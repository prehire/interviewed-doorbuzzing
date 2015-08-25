class Schedule < ActiveRecord::Base
  belongs_to :user

  validates :day_of_week, presence: true, numericality: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
