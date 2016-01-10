class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bookings
  has_many :gigs, through: :bookings
  has_many :reviews

  def role?(role_to_check)
    self.role.to_s == role_to_check.to_s
  end
end
