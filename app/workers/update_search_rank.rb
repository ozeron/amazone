class UpdateSearchRank
  @queue = :search_rank_queue

  def self.perform(search_rank_id)
    service = UpdateSearchRankService.new(search_rank_id)
    service.perform!
  end
end
