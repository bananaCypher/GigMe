class Gig < ActiveRecord::Base
    validates :price, :start_time, :end_time, :capacity, :act_id, :venue_id, presence: true
    validates :price, :capacity, numericality: {greater_than_or_equal_to: 0}

    belongs_to :act
    belongs_to :venue

    has_many :bookings
    has_many :users, through: :bookings
    has_many :reviews

    scope :available, -> { all.find_all { |gig|  gig.full? == false } }

    def clash?
        self.venue.gigs.each do |g|
            if g == self
                next
            end
            range = (g.start_time.to_i..g.end_time.to_i)
            if (range) === self.start_time.to_i
                return "The start time clashes with another gig at this venue"
            elsif (range) === self.end_time.to_i
                return "The end time clashes with another gig at this venue"
            end
        end
        return nil
    end

    def name
        self.act.name
    end

    def name_date
        "#{self.name} - #{self.pretty_start_date}"
    end

    def paragraph
        "#{self.act.name} are playing live at #{self.venue.name} on #{self.full_start}.  Tickets cost #{ActionController::Base.helpers.number_to_currency(self.price, unit: '£')}, book yours now before they sell out."
    end

    def average_rating
        return 0 if self.reviews.count == 0
        self.reviews.inject(0) {|sum, review| sum += review.rating} / self.reviews.count
    end

    def avg_rating_stars_range
        (1..self.average_rating)
    end

    def avg_rating_no_stars_range
        (1..(5 - self.average_rating)) 
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

    def pretty_start_time
        self.start_time.strftime("%H:%M")
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

    def start_ISO_8601
         self.start_time.iso8601.gsub('-', '').gsub(':', '')
    end

    def end_ISO_8601 
        self.end_time.iso8601.gsub('-', '').gsub(':', '')
    end

    def google_calendar_url
        name = url_stringify(self.name)
        start_date = start_ISO_8601
        end_date = end_ISO_8601
        details = url_stringify(self.paragraph)
        location = url_stringify(self.venue.name)

        url =  "https://www.google.com/calendar/render?action=TEMPLATE&text=#{name}&dates=#{start_date}/#{end_date}&details=#{details}&location=#{location}&sf=true&output=xml"

        return url
    end

    def passed?
        self.start_time < Time.now
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

    def url_stringify(string)
        string.split(' ').join('+')
    end
end
