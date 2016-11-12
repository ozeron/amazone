class UpdateSearchRanksJob < ActiveJob::Base
  queue_as :meta_queue

  def perform
    SearchTerm.all.pluck(:id).each do |id|
      UpdateSearchRankJob.perform_later(id)
    end
  end
end
