class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
  		t.integer :user_id
  		t.string :street
  		t.string :city
  		t.string :landmark
  		t.integer :pin

      t.timestamps null: false
    end
  end
end
