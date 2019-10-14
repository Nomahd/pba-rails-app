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

  attr_accessor :photo, :old_photo

  before_create :ftp_add, if: :link_photo
  before_update :ftp_replace, if: :link_photo
  before_destroy :ftp_destroy

  def self.destroy_selected(audio_messenger, devotion_messenger, video_messenger, video_guest)
    selected = nil
    unless audio_messenger.nil?
      selected = audio_messenger
    end
    unless devotion_messenger.nil?
      selected = devotion_messenger
    end
    unless video_messenger.nil?
      selected = video_messenger
    end
    unless video_guest.nil?
      selected = video_guest
    end
    Person.destroy(selected)
  end

  private

  def link_photo
    if photo.nil?
      false
    else
      self.old_photo = self.photo_link
      self.photo_link = photo.original_filename
      true
    end
  end

  def ftp_add
    FTPUtil.ftp_add(photo.path, "/profile_pictures/" + self.photo_link)
  end

  def ftp_replace
    FTPUtil.ftp_replace("/profile_pictures/" + old_photo, photo.path, "/profile_pictures/" + self.photo_link)
  end

  def ftp_destroy
    FTPUtil.ftp_delete("/profile_pictures/" + self.photo_link)
  end
end
