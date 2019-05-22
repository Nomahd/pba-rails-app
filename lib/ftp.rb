require 'net/ftp'

class FTP

  def self.ftp_add(local, remote)
    is_connected
    put_file(local, remote)
    close
  end

  def self.ftp_replace(old, local, remote)
    is_connected
    delete_file(old)
    put_file(local, remote)
    close
  end

  def self.ftp_delete(filename)
    is_connected
    delete_file(filename)
    close
  end

  def self.ftp_get(filename)
    is_connected
    get_file(filename)
    close
  end

  private
  @ftp

  def self.put_file(local, remote)
    begin
      @ftp.putbinaryfile(local, remote)
    rescue StandardError
      raise
    end
  end

  def self.delete_file(filename)
    begin
      @ftp.delete(filename)
    rescue Net::FTPPermError
      nil
    end
  end

  def self.get_file(filename)
    begin
      @ftp.get(filename)
    rescue StandardError
      raise
    end
  end

  def self.is_connected
    if @ftp == nil || @ftp.closed?
      begin
        @ftp = Net::FTP.open(ENV["FTP_HOST"], ENV["FTP_USER"], ENV["FTP_PASSWORD"])
      rescue StandardError
        raise
      end
    end
  end

  def self.close
    @ftp.close
  end
end
