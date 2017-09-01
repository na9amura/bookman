class Book < ApplicationRecord
  has_many :checks
  has_one :checking_out, -> { Check.out }, class_name: 'Check'
end
