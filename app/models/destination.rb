class Destination < ActiveRecord::Base
  belongs_to :user

  # Normalizes the attribute itself before validation
  phony_normalize :phone

  validates :name, presence: true
  validates :sequence, presence: true, numericality: true
  validates :phone, presence: true
  validates_plausible_phone :phone, country_code: Proc.new { |e| e.user.country_code } 

end
