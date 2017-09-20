class Book < ApplicationRecord
  belongs_to :shelf

  has_many :checks
  has_one :checking_out, -> { Check.out }, class_name: 'Check'

  has_many :tags
end
