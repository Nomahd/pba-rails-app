require 'zip'
require 'ftp_util'

class ZipUtil

  def self.file_count(file)
    file_count = 0
    Zip::File.open(file) do |zip_file|
      zip_file.each do
        file_count+=1
      end
    end
    file_count
  end

  def self.match_names(zip, array)
    Zip::File.open(zip) do |zip_file|
      zip_file.each do |file|
        unless array.include?(file.name)
          return false
        end
      end
    end
    true
  end

  def self.upload(zip)
    Zip::File.open(zip) do |zip_file|
      zip_file.each do |file|
        fpath = File.join('tmp/zip', file.name)
        zip_file.extract(file, fpath) unless File.exist?(fpath)
        FTPUtil.ftp_add(fpath, '/audio/' + file.name)
        # File.delete(fpath) if File.exists?(fpath)
      end
    end
  end
end