class Gig < ActiveRecord::Base
  belongs_to :act
  belongs_to :venue

  has_many :bookings
  has_many :users, through: :bookings

  def available_spaces
    self.capacity - self.users.count 
  end

  def full?
    self.available_spaces <= 0
  end

  scope :available, -> { all.find_all { |gig|  gig.full? == false } }
end
