class Code < ActiveRecord::Base
  belongs_to :user

  validates :pin, :numericality => { :greater_than_or_equal_to => 10000, :less_than_or_equal_to => 99999 }, :presence => true
  validates :name, :presence => true
end
