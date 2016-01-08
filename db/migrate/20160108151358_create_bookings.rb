class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :user_id
      t.string :integer
      t.string :gig_id
      t.string :integer

      t.timestamps null: false
    end
  end
end
