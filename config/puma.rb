# This configuration file will be evaluated by Puma. The top-level methods that
# are invoked here are part of Puma's configuration DSL. For more information
# about methods provided by the DSL, see https://puma.io/puma/Puma/DSL.html.

# The number of threads per worker.
threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
threads threads_count, threads_count

# Run a cluster of workers in production for better throughput.
workers ENV.fetch("WEB_CONCURRENCY", 2) if ENV["WEB_CONCURRENCY"]
preload_app! if ENV["WEB_CONCURRENCY"]

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port ENV.fetch("PORT", 3000)

# Specifies the `environment` that Puma will run in.
environment ENV.fetch("RAILS_ENV", "development")

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Specify the PID file. Defaults to tmp/pids/server.pid in development.
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
