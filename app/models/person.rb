class Person < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { scope: [ :context, :category ]},
            length: { maximum: 255 }

  validates :context,
            presence: true,
            length: { maximum: 255 }

  validates :category,
            presence: true,
            length: { maximum: 255 }
end
