# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chronos,
  ecto_repos: [Chronos.Repo]

# Configures the endpoint
config :chronos, Chronos.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "o92Sp/2g3Sic6h70Hh5L6xM0FDkQmZLOrsCvpRF5mRAeIkhCoPexLAHisVNBh346",
  render_errors: [view: Chronos.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chronos.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Chronos",
  ttl: {7, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "WHlJYfA8ERIVSryq3yGRFbidrwvPXsrvuM0jfeHnUCKWnh2tC+ILJp1FoPIn17hT",
  serializer: Chronos.GuardianSerializer
