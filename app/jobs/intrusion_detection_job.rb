class IntrusionDetectionJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "Something "
  end
end
