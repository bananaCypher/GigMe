class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :tag
      t.text :description

      t.timestamps null: false
    end
  end
end
