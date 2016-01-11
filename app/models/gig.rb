class Gig < ActiveRecord::Base
  validates :price, :start_time, :end_time, :capacity, :act_id, :venue_id, presence: true
  validates :price, :capacity, numericality: {greater_than_or_equal_to: 0}

  belongs_to :act
  belongs_to :venue

  has_many :bookings
  has_many :users, through: :bookings
  has_many :reviews

  scope :available, -> { all.find_all { |gig|  gig.full? == false } }

    def name
    self.act.name
    end
    def name_date
    "#{self.name} - #{self.pretty_start_date}"
    end

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

  def self.upcoming
    self.where("start_time >= ?", Time.now)
  end

  def pretty_start
    pretty_time(self.start_time)
  end

  def pretty_end
    pretty_time(self.end_time)
  end

  def pretty_start_date
    pretty_date(self.start_time)
  end

  def pretty_end_date
    pretty_date(self.end_time)
  end

  def full_start
    full_time(self.start_time)
  end

  def full_end
    full_time(self.end_time)
  end


  private
  def pretty_time(time)
    time.strftime("%d/%m/%Y %H:%M")
  end

  def pretty_date(time)
    time.strftime("%d/%m/%Y")
  end

  def full_time(time)
    case time.day
      when 1
        mod = 'st'
      when 2
        mod = 'nd'
      when 3
        mod = 'rd'
      else
        mod = 'th'
    end
    time.strftime("%-d#{mod} of %B %Y")
  end
end
