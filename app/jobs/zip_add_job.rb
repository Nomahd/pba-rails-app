class ZipAddJob < ApplicationJob
  queue_as :default

  # discard_on StandardError
  def perform(zip)
    ZipUtil.upload(zip)
  end
end
