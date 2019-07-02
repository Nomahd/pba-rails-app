require 'ftp_util'

class Audio < ApplicationRecord
  validates :title,
            presence: true,
            length: {maximum: 255}
  validates :date,
            presence: true
  validates :description,
            presence: true
  validates :speaker,
            length: {maximum: 255}
  validates :passage,
            length: {maximum: 255 }
  validates :filename,
            presence: true,
            length: { maximum: 255 }

  attr_accessor :audio_file, :old_file

  before_validation do
    if audio_file.nil?
      self.filename = nil
    else
      self.old_file = self.filename
      self.filename = audio_file.original_filename
    end
  end

  before_create do
    FTPUtil.ftp_add(audio_file.path, "/audio/" + self.filename)
  end

  before_update do
    FTPUtil.ftp_replace("/audio/" + old_file, audio_file.path, "/audio/" + self.filename)
  end

  before_destroy do
    FTPUtil.ftp_delete("/audio/" + self.filename)
  end
end
