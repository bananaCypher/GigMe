class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.decimal :price
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :capacity
      t.integer :act_id
      t.integer :venue_id

      t.timestamps null: false
    end
  end
end
