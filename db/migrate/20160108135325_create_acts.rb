class CreateActs < ActiveRecord::Migration
  def change
    create_table :acts do |t|
      t.string :name
      t.text :description
      t.text :image

      t.timestamps null: false
    end
  end
end
