class CreateActsKeywords < ActiveRecord::Migration
  def change
    create_table :acts_keywords do |t|
      t.integer :act_id
      t.integer :keyword_id
    end
  end
end
