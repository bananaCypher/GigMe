class Gig < ActiveRecord::Base
  belongs_to :act
  belongs_to :venue

  has_many :bookings
  has_many :users, through: :bookings

  scope :available, -> { all.find_all { |gig|  gig.full? == false } }

  def available_spaces
    self.capacity - self.users.count 
  end

  def full?
    self.available_spaces <= 0
  end

  def self.search(term)
    acts = Act.where('name LIKE ?', "%#{term}%")
    keywords = Keyword.where('tag LIKE ?', "%#{term}%")
    venues = Venue.where('name LIKE ?', "%#{term}%")
    acts = acts + keywords.map{|k| k.acts}.flatten.uniq
    (acts.map{|a| a.gigs}.flatten + venues.map{|v| v.gigs}.flatten).uniq
  end

  def pretty_start
    pretty_time(self.start_time)
  end

  def pretty_end
    pretty_time(self.end_time)
  end

  def pretty_time(time)
    time.strftime("%d/%m/%Y %H:%M")
  end
end
