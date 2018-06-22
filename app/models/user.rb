class User < ActiveRecord::Base
  has_secure_password
  has_many :products #Products the user has created
  has_many :products_bought, through: :purchases, source: :product #Products the user has bought

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  before_save :downcase_fields
  
  validates :first_name, :last_name, :email, :password, presence: true
  validates :first_name, :last_name, length: { in: 2..25 }
  validates :password, length: { minimum: 8 }, on: :create
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX }


   def downcase_fields
      self.email.downcase!
   end
end
