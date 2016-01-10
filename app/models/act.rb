class Act < ActiveRecord::Base
  validates :name, presence: true, length: { in: 2..200 }
  validates :description, length: { in: 2..1000 }
  validates :image, length: { in: 2..500 }

  has_many :gigs
  has_many :venues, through: :gigs
  has_and_belongs_to_many :keywords, uniq: true
end