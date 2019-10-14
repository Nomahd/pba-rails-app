require_relative '../utils/csv_util'

class Video < ApplicationRecord

  validates :program_num,
            length: { maximum: 255 }
  validates :title,
            presence: true,
            length: { maximum: 255 }
  validates :broadcast_date,
            presence: true
  validates :program_name,
            length: { maximum: 255 }
  validates :guest,
            length: { maximum: 255 }
  validates :messenger,
            length: { maximum: 255 }
  validates :bible_book,
            length: {maximum: 255 }
  validates :link,
            presence: true,
            length: { maximum: 255 }
  validates :filename,
            length: { maximum: 255 }

  acts_as_taggable_on :genres, :themes, :specials

  before_save do
    if for_sale.nil?
      self.for_sale = false
    end
  end

  after_save do

    Program.create(name: self.program_name, context: :video)
    Person.create(name: self.guest, context: :video, category: :guest)
    Person.create(name: self.messenger, context: :video, category: :messenger)

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
    [Video.count, Video.order(:broadcast_date).last]
  end

  def self.save(file)
    csv = Bulk.create({:csv => file})
    csv.id
  end

  def self.bulk(rows, id)
    BulkAddJob.perform_later(rows, "Video", 13, 15, id)
  end

  def self.search(params)

    search = Video.where("program_num LIKE ?", "%#{params[:search_program_number]}%")
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
                 .where("program_name LIKE ?", "%#{params[:search_program_name]}%")
                 .where("guest LIKE ?", "%#{params[:search_guest]}%")
                 .where("messenger LIKE ?", "%#{params[:search_messenger]}%")
                 .where("bible_book LIKE ?", "%#{params[:search_bible_book]}%")
                 .where("link LIKE ?", "%#{params[:search_link]}%")
                 .where("filename LIKE ?", "%#{params[:search_filename]}%")

    unless params[:search_genre_tag].blank?
      genreSearch = Video.tagged_with(params[:search_genre_tag], :on => :genres)
      search.merge!(genreSearch)
    end
    unless params[:search_theme_tag].blank?
      themeSearch = Video.tagged_with(params[:search_theme_tag], :on => :themes)
      search.merge!(themeSearch)
    end
    unless params[:search_special_tag].blank?
      specialSearch = Video.tagged_with(params[:search_special_tag], :on => :specials)
      search.merge!(specialSearch)
    end

    search
  end
end
