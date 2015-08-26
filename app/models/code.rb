class Code < ActiveRecord::Base
  belongs_to :user

  validates :pin, numericality: { greater_than_or_equal_to: 10_000, less_than_or_equal_to: 99_999 }, presence: true
  validates :name, presence: true
end
