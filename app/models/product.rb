class Product < ActiveRecord::Base
  belongs_to :user
  validates :name, :amount, presence: true
  validates_inclusion_of :amount, in: 1..10000, message: "must be from 1 - 10,000"
end
