class Video < ApplicationRecord
  validates :title,
            presence: true,
            length: {maximum: 255}
  validates :date,
            presence: true
  validates :description,
            presence: true
  validates :speaker,
            length: {maximum: 255 }
  validates :passage,
            length: {maximum: 255 }
  validates :link,
            presence: true,
            length: { maximum: 255 }

end
