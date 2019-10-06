require_relative '../utils/ftp_util'
require_relative '../utils/bulk_util'
require_relative '../utils/zip_util'

class Audio < ApplicationRecord

  validates :program_num,
            length: { maximum: 255 }
  validates :title,
            presence: true,
            length: {maximum: 255}
  validates :broadcast_date,
            presence: true
  validates :program_name,
            length: { maximum: 255 }
  validates :messenger,
            length: { maximum: 255 }
  validates :bible_book,
            length: {maximum: 255 }
  validates :filename,
            length: { maximum: 255 }

  acts_as_taggable_on :genres, :themes, :specials

  attr_accessor :audio_file, :old_file

  before_save do
    if for_sale.nil?
      self.for_sale = false
    end
  end

  after_save do

    Program.create(name: self.program_name, context: :audio)
    Person.create(name: self.messenger, context: :audio, category: :messenger)

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

  before_validation :check_audio_file, if: :ignore_file?

  before_create :ftp_add, if: :ignore_file?

  before_update :ftp_replace, if: :ignore_file?

  before_destroy :ftp_destroy, if: :ignore_file?

  def self.summary
    [Audio.count, Audio.order(:broadcast_date).last]
  end

  def self.save(csv, zip)
    unless File.directory?('tmp/csv')
      FileUtils.mkdir_p('tmp/csv')
    end
    unless File.directory?('tmp/zip')
      FileUtils.mkdir_p('tmp/zip')
    end
    unless csv == nil
      FileUtils.cp(csv, 'tmp/csv')
    end
    unless zip == nil
      uploaded_file = zip
      File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
        file.write(uploaded_file.read)
      end
    end
  end

  def self.save(file)
    unless File.directory?('tmp/csv')
      FileUtils.mkdir_p('tmp/csv')
    end
    FileUtils.cp(file, 'tmp/csv')
  end

  def self.bulk(file)
    filepath = 'tmp/csv/' + file
    BulkAddJob.perform_later(filepath, "Audio", 7, 9)
  end

  def self.search(params)

    search = Audio.where("program_num LIKE ?", "%#{params[:search_program_number]}%")
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
                 .where("messenger LIKE ?", "%#{params[:search_messenger]}%")
                 .where("bible_book LIKE ?", "%#{params[:search_bible_book]}%")
                 .where("filename LIKE ?", "%#{params[:search_filename]}%")

    unless params[:search_genre_tag].blank?
      genreSearch = Audio.tagged_with(params[:search_genre_tag], :on => :genres)
      search.merge!(genreSearch)
    end
    unless params[:search_theme_tag].blank?
      themeSearch = Audio.tagged_with(params[:search_theme_tag], :on => :themes)
      search.merge!(themeSearch)
    end
    unless params[:search_special_tag].blank?
      specialSearch = Audio.tagged_with(params[:search_special_tag], :on => :specials)
      search.merge!(specialSearch)
    end

    search
  end

  private

  def ignore_file?
    self.audio_file != 'ignore'
  end

  def check_audio_file
    if self.audio_file.nil?
      self.errors.add(:audio_file, I18n.t('audios_file_error'))
    else
      self.old_file = self.filename
      self.filename = audio_file.original_filename
    end
  end

  def ftp_add
    FTPUtil.ftp_add(audio_file.path, "/audio/" + self.filename)
  end

  def ftp_replace
    FTPUtil.ftp_replace("/audio/" + old_file, audio_file.path, "/audio/" + self.filename)
  end

  def ftp_destroy
    FTPUtil.ftp_delete("/audio/" + self.filename)
  end
end