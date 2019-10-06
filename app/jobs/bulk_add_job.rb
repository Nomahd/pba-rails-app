class BulkAddJob < ApplicationJob
  queue_as :default

  discard_on StandardError

  def perform(filename, classname, start_index, end_index)

    BulkUtil.bulk_add(filename, classname, start_index, end_index)
    File.chmod(0777, filename)
    File.delete(filename)
  end
end
