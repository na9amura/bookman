class Book < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :shelf, optional: true
  has_many :tag_assigns
  has_many :tags, through: :tag_assigns
  has_many :checks
  has_one :checking_out, -> { Check.out }, class_name: 'Check'

  def self.import(attributes)
    book = Book.new(attributes.reject { |k| k.to_sym == :image_url })
    book.image = open(attributes[:image_url])
    book
  end

  def try_assign_tag(name)
    return if tags.find_by(name: name)
    if tag = Tag.find_by(name: name)
      self.tag_assigns.new(tag: tag)
    else
      self.tag_assigns.new(tag: Tag.new(name: name))
    end
  end

  def delete_tag(tag_id)
    tag_assigns.find_by(tag_id: tag_id).tap(&:destroy)
  end
end
