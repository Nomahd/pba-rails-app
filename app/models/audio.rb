require 'net/ftp'

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

  attr_accessor :audio_file

  before_validation do
    self.filename = audio_file.original_filename
  end

  before_create do
    ftp_open do |ftp|
      ftp.putbinaryfile(audio_file.path, self.filename)
      ftp.close
    end
  end

  before_update do
    ftp_open do |ftp|
      ftp.delete(self.filename)
      ftp.putbinaryfile(audio_file.path, self.filename)
      ftp.close
    end
  end

  before_destroy do
    ftp_open do |ftp|
      begin
        ftp.delete(self.filename)
      rescue Net::FTPPermError
        nil
      end
      ftp.close
    end
  end

  def ftp_open
    yield Net::FTP.open("ftp.pba.on-rev.com", "app@pba.on-rev.com", "omfpba2019")
  end
end
