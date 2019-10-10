class DeleteJob < ApplicationJob
  queue_as :default

  discard_on StandardError

  def perform(model_string)
    model = Object.const_get(model_string)
    all_content = model.all
    ActionCable.server.broadcast("delete_progress", total: all_content.length)
    all_content.each do |content|
      content.destroy
      ActionCable.server.broadcast("delete_progress", 'success')
    end
  end
end
