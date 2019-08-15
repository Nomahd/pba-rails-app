class Program < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { scope: :context },
            length: { maximum: 255 }

  validates :context,
            presence: true,
            length: { maximum: 255 }
end
