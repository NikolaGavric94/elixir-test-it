# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :infinityloop, Infinityloop.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "A1yNCeCvbHWnfFfG/fcfBnT8Ptf1VQNVUsoL0HxyZ67RtNAgi7y7qk1tC/QBcKug",
  debug_errors: false,
  pubsub: [name: Infinityloop.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

 config :mailer,
    templates: "priv/templates"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
