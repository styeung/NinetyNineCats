class AddConstraintsToCatAndRentalTables < ActiveRecord::Migration
  def change
    remove_column :cats, :user_id, :integer
    remove_column :cat_rental_requests, :user_id, :integer

    add_column :cats, :user_id, :integer, null: false
    add_column :cat_rental_requests, :user_id, :integer, null: false

  end
end
