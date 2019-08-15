class TagMeta < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { scope: :category },
            length: { maximum: 255 }
  validates :category,
            presence: true,
            length: { maximum: 255 }
end
