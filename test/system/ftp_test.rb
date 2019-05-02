require 'net/ftp'

def ftp_open
  yield Net::FTP.open('ftp.pba.on-rev.com', 'app@pba.on-rev.com', 'omfpba2019')
end

ftp_open do |ftp|
  ftp.puttextfile(File.dirname(__FILE__) + '/test.txt')
end


