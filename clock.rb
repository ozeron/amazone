# frozen_string_literal: true
require 'clockwork'
require_relative './config/boot'
require_relative './config/environment'

module Clockwork
  handler do |job|
    job.constantize.perform_later
  end

  # error_handler do |error|
  #   Airbrake.notify(
  #     error,
  #     { error_message: 'Error with Clockwork when trying to add new task',
  #       cgi_data: ENV.to_hash })
  #
  #   puts 'Error with Clockwork when trying to add new task.'
  #   puts '########################################################'
  #   puts error
  #   puts '########################################################'
  #   puts ''
  # end

  every(20.minutes, 'UpdateSearchRanksJob')
end
