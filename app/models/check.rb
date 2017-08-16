class Check < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: {
    out: 0,
    in: 10,
  }

  validate :book_checked_out?

  def self.out_new(book_id, user_id)
    return false unless Book.where(id: book_id).exists?
    instance = Check.new(book_id: book_id, user_id: user_id)
    instance.tap(&:save)
  end

  private

    def book_checked_out?
      if Check.where(book_id: book_id, status: 0).exists?
        @errors.add(:book_id, 'は貸し出し中です')
      end
    end
end
