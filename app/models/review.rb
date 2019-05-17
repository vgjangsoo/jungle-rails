class Review < ActiveRecord::Base
  # Add validations to a review.
  validates :product, presence: true
  validates :user, presence: true
  validates :description, presence: true
  validates :rating, presence: true
  
  # Review belongs to the product.
  belongs_to :product, :user
end
