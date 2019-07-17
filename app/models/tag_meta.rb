class TagMeta < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { scope: :context },
            length: {maximum: 255}


  def self.get(context, category)
    TagMeta.where(context: context, category: category)
  end
end
