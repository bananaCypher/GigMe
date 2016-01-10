class Keyword < ActiveRecord::Base
  validates :tag, presence: true
  validates :tag, length: { in: 2..200 }
  validates :description, length: { in: 2..1000 }

  has_and_belongs_to_many :acts, uniq: true
end
