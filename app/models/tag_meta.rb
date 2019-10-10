class TagMeta < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { scope: :category },
            length: { maximum: 255 }
  validates :category,
            presence: true,
            length: { maximum: 255 }

  def self.option_destroy(id)
    @tag = TagMeta.find(id)
    tagged = ActsAsTaggableOn::Tag.where(name: @tag.name).first
    unless tagged.nil?
      tagged.destroy
    end
    @tag.destroy
  end

  def self.destroy_selected(genre, theme, special)
    selected = nil
    unless genre.nil?
      selected = genre
    end
    unless theme.nil?
      selected = theme
    end
    unless special.nil?
      selected = special
    end
    tags = TagMeta.find(selected)
    tagged = []
    tags.each do |t|
      acts = ActsAsTaggableOn::Tag.where(name: t.name).first
      unless acts.blank?
        tagged.push(acts.id)
      end
    end

    unless tagged.blank?
      ActsAsTaggableOn::Tag.destroy(tagged)
    end
    TagMeta.destroy(selected)
  end
end
