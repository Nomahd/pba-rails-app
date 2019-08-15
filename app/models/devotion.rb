require_relative '../utils/bulk_util'

class Devotion < ApplicationRecord
  validates :pba_id,
            length: {maximum: 255}
  validates :title,
            presence: true,
            length: {maximum: 255}
  validates :broadcast_date,
            presence: true
  validates :body,
            presence: true
  validates :messenger,
            length: {maximum: 255}
  validates :bible_book,
            length: {maximum: 255}

  acts_as_taggable_on :genres, :themes, :specials

  after_save do

    Person.create(name: self.messenger, context: :devotion, category: :messenger)

    self.genre_list.each do |tag|
      TagMeta.create(:name => tag, :category => 'genre')
    end

    self.theme_list.each do |tag|
      TagMeta.create(:name => tag, :category => 'theme')

    end

    self.special_list.each do |tag|
      TagMeta.create(:name => tag, :category => 'special')
    end
  end

  def self.summary
    [Devotion.count, Devotion.order(:broadcast_date).last]
  end

  def self.bulk(file)
    BulkUtil.bulk_add(file, Devotion, 7, 9)
  end

  def self.search(params)

    search = Devotion.where("pba_id LIKE ?", "%#{params[:search_id]}%")
      .where("title LIKE ?", "%#{params[:search_title]}%")
      .where("broadcast_date >= ? AND broadcast_date <= ?",
             params['search_date_start(1i)'].blank? ? Date.new(0000, 01, 01) :
             Date.parse("%04d" % params["search_date_start(1i)"].to_s +
                            "%02d" % params["search_date_start(2i)"].to_s +
                            "%02d" % params["search_date_start(3i)"].to_s),
             params['search_date_end(1i)'].blank? ? Date.new(9999, 12, 31):
                 Date.parse("%04d" % params["search_date_end(1i)"].to_s +
                            "%02d" % params["search_date_end(2i)"].to_s +
                            "%02d" % params["search_date_end(3i)"].to_s))
      .where("messenger LIKE ?", "%#{params[:search_messenger]}%")
      .where("bible_book LIKE ?", "%#{params[:search_bible_book]}%")

    unless params[:search_genre_tag].blank?
      genreSearch = Devotion.tagged_with(params[:search_genre_tag], :on => :genres)
      search.merge!(genreSearch)
    end
    unless params[:search_theme_tag].blank?
      themeSearch = Devotion.tagged_with(params[:search_theme_tag], :on => :themes)
      search.merge!(themeSearch)
    end
    unless params[:search_special_tag].blank?
      specialSearch = Devotion.tagged_with(params[:search_special_tag], :on => :specials)
      search.merge!(specialSearch)
    end

    search
  end
end
