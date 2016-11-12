class UpdateSearchRankJob < ActiveJob::Base
  queue_as :search_rank_queue

  def perform(search_term_id)
    puts 'performing: UpdateSearchRankJob'
    service = UpdateSearchRankService.new(search_term_id)
    service.perform!
  end
end
