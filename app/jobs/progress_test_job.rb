class ProgressTestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "starting job"
    x = 0
    go = true
    while go do
      ActionCable.server.broadcast("test", x)
      x += 1
      sleep(0.01)
      if x > 100
        go = false
      end
    end
  end
end
