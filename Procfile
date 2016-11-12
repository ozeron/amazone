# Clockwork
# using it instead of resque-scheduler to properly add jobs via ActiveJob
clock: bundle exec clockwork clock.rb

# Resque scheduler for delayed jobs
resque_scheduler: bin/rake resque:scheduler

worker: QUEUE=* bundle exec rake resque:work
