class User < ApplicationRecord
  has_secure_password

  has_many :checks
  has_many :checkouts, -> { out? }, class_name: 'Check'
  has_many :books, through: :checkouts
end
