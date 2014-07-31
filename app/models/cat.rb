class Cat < ActiveRecord::Base
  COLORS = ["brown", "black", "white", "blue", "red", "pink"]

  validates :age, numericality: true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: %w(M F)
  validates :age, :birth_date, :color, :name, :sex, presence: true

  has_many(
    :cat_rental_requests,
    :class_name => "CatRentalRequest",
    :foreign_key => :cat_id,
    :primary_key => :id
  )

  belongs_to(
    :owner,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

end
