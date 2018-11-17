class User < ApplicationRecord
  has_many :recipes

  has_secure_password
  before_save { |user| user.email = user.email.downcase }

end
