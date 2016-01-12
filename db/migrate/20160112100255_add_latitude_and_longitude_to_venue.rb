class AddLatitudeAndLongitudeToVenue < ActiveRecord::Migration
  def change
      add_column :venues, :latitude, :decimal
      add_column :venues, :longitude, :decimal
  end
end
