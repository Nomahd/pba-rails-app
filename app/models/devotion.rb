class Devotion < ApplicationRecord
  validates :title,
            presence: true,
            length: {maximum: 255}
  validates :date,
            presence: true
  validates :body,
            presence: true
  validates :passage,
            length: {maximum: 255 }
  validates :messenger,
            length: {maximum: 255}
  validates :book_title,
            length: {maximum: 255}

end
