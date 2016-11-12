class UpdateSearchRankJob < ActiveJob::Base
  queue_as :search_rank_queue

  def perform(search_rank_id)
    service = UpdateSearchRankService.new(search_rank_id)
    service.perform!
  end
end
