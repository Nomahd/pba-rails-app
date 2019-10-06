class ViewTesterController < ApplicationController
  after_action :job_process, only: [:test]
  def test

    render 'view_tester/test'
  end

  def async
    ProgressTestJob.perform_later
  end

  def job_process
    ProgressTestJob.set(wait: 3.seconds).perform_later
  end
end
