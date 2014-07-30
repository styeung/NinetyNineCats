class Cat < ActiveRecord::Base
  validates :age, numericality: true
  validates :color, inclusion: %w(brown black white blue red pink)
  validates :sex, inclusion: %w(M F)
  validates :age, :birth_date, :color, :name, :sex, presence: true

  COLORS = ["brown", "black", "white", "blue", "red", "pink"]

end
