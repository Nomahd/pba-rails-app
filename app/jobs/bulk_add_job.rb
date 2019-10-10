class BulkAddJob < ApplicationJob
  queue_as :default

  discard_on StandardError

  def perform(rows, classname, start_index, end_index, id)

    BulkUtil.bulk_add(rows, classname, start_index, end_index)
    Bulk.destroy(id)
  end
end
