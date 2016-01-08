class Gig < ActiveRecord::Base
  belongs_to :act
  belongs_to :venue
  
end
