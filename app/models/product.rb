class Product < ActiveRecord::Base
  validates :name, length: { maximum: 50 }, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000 },
                    presence: true
  validates :description, length: { maximum: 400 }
end
