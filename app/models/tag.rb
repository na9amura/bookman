class Tag < ApplicationRecord
  has_many :tag_assign
  has_many :books, through: :tag_assign

  validates :name,
    uniqueness: true,
    presence: true
end
