class Shelf < ApplicationRecord
  belongs_to :admin_user, class_name: 'User'
  has_many :books
end
