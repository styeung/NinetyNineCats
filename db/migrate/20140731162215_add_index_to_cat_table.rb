class AddIndexToCatTable < ActiveRecord::Migration
  def change
    add_index :cats, :user_id, unique: true
    add_index :cat_rental_requests, :user_id, unique: true
  end
end
