class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.integer :user_id
      t.integer :button_id

      t.timestamps
    end
    add_index :clicks, :user_id
    add_index :clicks, :button_id
  end
end
