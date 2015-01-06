workers = Integer(ENV['WEB_WORKER_COUNT'] || 4 )
min_threads = Integer(ENV['WEB_MIN_THREADS'] || 1)
max_threads = Integer(ENV['WEB_MAX_THREADS'] || 16)
# NOTE: On Heroku, they advise setting min_threads and max_threads to be the same value

workers workers
threads min_threads, max_threads

# Reduces the startup time of the worker processes if enabled (currently will raise a warning if enabled and NewRelic makes a HTTP(S) connection on startup)
# Reference: https://github.com/puma/puma/commit/a2288fd6564ee9cdfa2d6596c488114ef2d000c9 (Recently added - 24/11/2014)
# If disabled Puma runs in phased-restart mode, where workers are killed and restarted one-by-one
preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 5000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do |worker_index|
  logger = Logger.new(STDOUT)
  logger.info("Worker #{worker_index} booting...")
end
